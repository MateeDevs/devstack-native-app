//
//  Created by Petr Chmelar on 30/10/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: StateButton {
    /// Reactive wrapper for `isOn` property.
    var isOn: ControlProperty<Bool> {
        controlProperty(
            editingEvents: [.touchUpInside],
            getter: { base in
                base.isOn
            },
            setter: { base, value in
                base.isOn = value
            }
        )
    }
}
