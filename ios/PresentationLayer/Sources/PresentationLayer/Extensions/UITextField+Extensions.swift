//
//  Created by Petr Chmelar on 10/11/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

extension UITextField {

    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: L10n.done, style: .done, target: self, action: #selector(doneButtonAction))

        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()
        inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonAction() {
        resignFirstResponder()
    }
}
