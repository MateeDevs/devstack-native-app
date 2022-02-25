//
//  Created by Petr Chmelar on 29/10/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: ImagePickerViewController {
    /// Reactive wrapper for `delegate`
    var delegate: DelegateProxy<ImagePickerViewController, ImagePickerViewControllerDelegate> {
        RxImagePickerViewControllerDelegateProxy.proxy(for: base)
    }

    /// Reactive wrapper for delegate method `photoSelected`
    var photoSelected: Observable<UIImage> {
        delegate
            .methodInvoked(#selector(ImagePickerViewControllerDelegate.photoSelected(image:)))
            .map { a in try castOrThrow(UIImage.self, a[0]) }
    }
}

extension ImagePickerViewController: HasDelegate {
    typealias Delegate = ImagePickerViewControllerDelegate
}

class RxImagePickerViewControllerDelegateProxy: DelegateProxy<ImagePickerViewController, ImagePickerViewControllerDelegate>,
    DelegateProxyType,
    ImagePickerViewControllerDelegate {
    
    /// Typed parent object.
    private(set) weak var imagePickerViewController: ImagePickerViewController?

    /// - parameter imagePickerViewController: Parent object for delegate proxy.
    init(imagePickerViewController: ParentObject) {
        self.imagePickerViewController = imagePickerViewController
        super.init(parentObject: imagePickerViewController, delegateProxy: RxImagePickerViewControllerDelegateProxy.self)
    }

    // Register known implementations
    static func registerKnownImplementations() {
        self.register { RxImagePickerViewControllerDelegateProxy(imagePickerViewController: $0) }
    }
}

private func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else { throw RxCocoaError.castingError(object: object, targetType: resultType) }
    return returnValue
}
