//
//  Created by Petr Chmelar on 21/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: BaseViewController {
    /// Bindable sink for `handleAlertAction()` method
    var alertAction: Binder<AlertAction> {
        Binder(self.base) { base, action in
            base.handleAlertAction(action)
        }
    }
}
