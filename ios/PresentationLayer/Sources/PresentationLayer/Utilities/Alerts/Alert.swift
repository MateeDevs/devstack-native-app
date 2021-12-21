//
//  Created by Petr Chmelar on 28/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

struct Alert {
    let title: String
    let message: String?
    let primaryAction: UIAlertAction
    let secondaryAction: UIAlertAction?
    
    init(
        title: String,
        message: String? = nil,
        primaryAction: UIAlertAction = UIAlertAction(title: L10n.dialog_error_close_text, style: .default, handler: nil),
        secondaryAction: UIAlertAction? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
    
    static func == (lhs: Alert, rhs: Alert) -> Bool {
        lhs.title == rhs.title &&
            lhs.message == rhs.message &&
            lhs.primaryAction == rhs.primaryAction &&
            lhs.secondaryAction == rhs.secondaryAction
    }
}
