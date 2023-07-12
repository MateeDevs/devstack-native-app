//
//  Created by David Kadlček on 12.05.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import SwiftUI

public struct RemoteImage: View {
    
    @State private var image: Image?
    private let stringURL: String?
    private let placeholder: Image
    private let contentMode: ContentMode
    
    public init(
        stringURL: String?,
        placeholder: Image,
        contentMode: ContentMode = .fit
    ) {
        self.stringURL = stringURL
        self.placeholder = placeholder
        self.contentMode = contentMode
    }
    
    public var body: some View {
        if let image {
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } else if let stringURL = stringURL, let url = URL(string: stringURL) {
            placeholderContent()
                .skeleton(true)
                .onAppear(perform: { downloadRemoteImage(from: url) })
        } else {
            failureContent()
        }
    }
}
    
private extension RemoteImage {
    
    // MARK: - Subviews

    func placeholderContent() -> some View {
        placeholder
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }

    func failureContent() -> some View {
        placeholderContent()
    }
    
    // MARK: - Remote image downloading
    
    func downloadRemoteImage(from url: URL) {
        Task {
            image = await downloadImage(from: url)
        }
    }
    
    func downloadImage(from url: URL) async -> Image? {
        do {
            let cache = URLCache.shared
            let urlRequest = URLRequest(url: url)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if cache.cachedResponse(for: urlRequest) == nil {
                cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: urlRequest)
            }
            
            guard let uiImage = UIImage(data: data) else { return nil }
            return Image(uiImage: uiImage)
        } catch {
            return nil
        }
    }
}
