//
//  Created by Petr Chmelar on 29/10/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UserImageView {
    /// Bindable sink for `placeholder` property
    var initials: Binder<String?> {
        Binder(base) { base, initials in
            base.initials = initials
        }
    }

    /// Bindable sink for `image` property
    var image: Binder<UIImage?> {
        Binder(base) { base, image in
            base.image = image
        }
    }

    /// Bindable sink for `imageURL` property
    var imageURL: Binder<String?> {
        Binder(base) { base, imageURL in
            base.imageURL = imageURL
        }
    }

    /// Bindable sink for `placeholder` property
    var placeholder: Binder<UIImage?> {
        Binder(base) { base, placeholder in
            base.placeholder = placeholder
        }
    }
}
