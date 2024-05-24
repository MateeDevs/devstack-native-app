//
//  Created by Julia Jakubcova on 24/05/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import SwiftUI
import UIKit

enum ImagePickerFlow: Flow, Equatable {
}

public protocol ImagePickerFlowControllerDelegate: AnyObject {
//    func photoSelected(image: UIImage)
}

public final class ImagePickerFlowController: FlowController {

    private weak var delegate: ImagePickerFlowControllerDelegate?
    
    private let pickMedia: (NSURL?) -> Void
    
    public init(
        pickMedia: @escaping (NSURL?) -> Void,
        navigationControler: UINavigationController
    ) {
        self.pickMedia = pickMedia
        super.init(navigationController: navigationControler)
    }
    
    override public func setup() -> UIViewController {
        
        let actionSheetController = UIAlertController(title: L10n.image_picker_title, message: L10n.image_picker_subtitle, preferredStyle: .actionSheet)

        let photoLibrary = UIAlertAction(title: L10n.image_picker_library, style: .default, handler: { _ in
            self.selectMedia(sourceType: .photoLibrary)
        })
        actionSheetController.addAction(photoLibrary)

        let cancel = UIAlertAction(title: L10n.image_picker_cancel, style: .cancel, handler: nil)
        actionSheetController.addAction(cancel)

        return actionSheetController
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let flow = flow as? ImagePickerFlow else { return }
        switch flow {
        }
    }
}

// MARK: Share flow
private extension ImagePickerFlowController {
   func selectMedia(sourceType: UIImagePickerController.SourceType) {
       guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
       let imagePicker = UIImagePickerController()
       imagePicker.delegate = self
       imagePicker.allowsEditing = false
       imagePicker.sourceType = sourceType
       imagePicker.mediaTypes = ["public.movie"]
       
       if let top = navigationController.presentedViewController {
           top.present(imagePicker, animated: true)
       } else {
           navigationController.present(imagePicker, animated: true)
       }
    }
    
    func chooseMedia(mediaURL: NSURL?) {
        pickMedia(mediaURL)
    }
}

extension ImagePickerFlowController: UIImagePickerControllerDelegate {
    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        guard let selectedMediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL else { return }

        chooseMedia(mediaURL: selectedMediaURL)
        
        if let top = navigationController.presentedViewController {
            top.dismiss(animated: true)
        } else {
            navigationController.dismiss(animated: true, completion: nil)
        }
    }
}

