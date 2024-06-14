//
//  Created by Krystof Prihoda on 18.04.2024.
//  Copyright © 2024 Matee. All rights reserved.
//

import SwiftUI
import PhotosUI

public enum MediaType: Hashable {
    case photo(UIImage)
    case video(URL)
}

public protocol MediaPickerSource: AnyObject {
    var media: Binding<[MediaType]> { get }
}

public struct MediaPickerView: UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = PHPickerViewController
    
    @Binding private var media: [MediaType]
    private var selectionLimit: Int
    private var filter: PHPickerFilter?
    private var itemProviders: [NSItemProvider]
    
    public init(
        media: Binding<[MediaType]>,
        selectionLimit: Int = 5,
        filter: PHPickerFilter? = PHPickerFilter.any(of: [.images, .videos]),
        itemProviders: [NSItemProvider] = []
    ) {
        self._media = media
        self.selectionLimit = selectionLimit
        self.filter = filter
        self.itemProviders = itemProviders
    }
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = self.filter
        configuration.selectionLimit = self.selectionLimit
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        return MediaPickerView.Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
        
        var parent: MediaPickerView
        
        init(parent: MediaPickerView) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            if !results.isEmpty {
                parent.itemProviders = []
                parent.media = []
            }
            
            parent.itemProviders = results.map(\.itemProvider)
            loadMedia()
        }
        
        private func loadMedia() {
            for itemProvider in parent.itemProviders {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        guard let self = self else { return }
                        
                        if let image = image as? UIImage {
                            self.parent.media.append(MediaType.photo(image))
                        } else {
                            print("Could not load image", error?.localizedDescription ?? "")
                        }
                    }
                } else if itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                    itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { [weak self] url, error in
                        guard let self = self else { return }
                        
                        if let url = url {
                            self.parent.media.append(MediaType.video(url))
                        } else {
                            print("Could not load video", error?.localizedDescription ?? "")
                        }
                    }
                }
            }
        }
        
    }
}
