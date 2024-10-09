//
//  Created by Krystof Prihoda on 18.04.2024.
//  Copyright © 2024 Matee. All rights reserved.
//

import SwiftUI
import PhotosUI

public enum MediaType: Hashable {
    case photo(src: UIImage, id: String?)
}

public protocol MediaPickerSource: AnyObject {
    var media: Binding<[MediaType]> { get }
}

public struct MediaPickerView: UIViewControllerRepresentable {
    public typealias UIViewControllerType = PHPickerViewController
    
    @Binding private var media: [MediaType]
    private var selectionLimit: Int
    private var filter: PHPickerFilter?
    
    public init(
        media: Binding<[MediaType]>,
        selectionLimit: Int = 5,
        filter: PHPickerFilter? = PHPickerFilter.any(of: [.images])
    ) {
        self._media = media
        self.selectionLimit = selectionLimit
        self.filter = filter
    }
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = self.filter
        configuration.selectionLimit = self.selectionLimit
        configuration.preselectedAssetIdentifiers = self.media.compactMap { media in
            switch media {
            case let .photo(src: _, id: id): return id
            }
        }
        configuration.selection = .ordered
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
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

            loadMedia(from: results)
        }
        
        private func loadMedia(from results: [PHPickerResult]) {
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        guard let self else { return }
                        
                        if let image = image as? UIImage {
                            DispatchQueue.main.schedule {
                                self.parent.media.append(MediaType.photo(src: image, id: result.assetIdentifier))
                            }
                        } else {
                            print("Could not load image", error?.localizedDescription ?? "")
                        }
                    }
                }
            }
        }
        
    }
}
