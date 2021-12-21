//
//  Created by Petr Chmelar on 21/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIView {
    /// Bindable sink for `startActivityIndicator()`, `stopActivityIndicator()` methods
    var activityIndicator: Binder<Bool> {
        Binder(self.base) { base, isLoading in
            isLoading ? base.startActivityIndicator() : base.stopActivityIndicator()
        }
    }
}
