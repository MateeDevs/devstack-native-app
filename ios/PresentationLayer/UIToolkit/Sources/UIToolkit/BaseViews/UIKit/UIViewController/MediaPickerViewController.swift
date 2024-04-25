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

struct MediaPickerViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = PHPickerViewController
    
    @Binding var media: [MediaType]
    var selectionLimit: Int
    var filter: PHPickerFilter? = PHPickerFilter.any(of: [.images, .videos])
    var itemProviders: [NSItemProvider] = []
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = self.filter
        configuration.selectionLimit = self.selectionLimit
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return MediaPickerViewController.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
        
        var parent: MediaPickerViewController
        
        init(parent: MediaPickerViewController) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
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
