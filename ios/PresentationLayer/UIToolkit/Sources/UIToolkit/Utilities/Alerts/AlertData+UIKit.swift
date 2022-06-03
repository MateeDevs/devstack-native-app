//
//  Created by Petr Chmelar on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import UIKit

public extension UIAlertAction {
    convenience init(_ action: AlertData.Action) {
        self.init(
            title: action.title,
            style: .init(action.style),
            handler: { _ in action.handler() }
        )
    }
}

public extension UIAlertAction.Style {
    init(_ style: AlertData.Action.Style) {
        switch style {
        case .default: self = .default
        case .cancel: self = .cancel
        case .destruction: self = .destructive
        }
    }
}
