//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

class LocalizedTextField: UITextField {

    // MARK: UI components

    // MARK: Stored properties

    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        if let placeholder = placeholder {
            self.placeholder = NSLocalizedString(placeholder, bundle: .module, comment: "")
        }
    }

    // MARK: Additional methods
}
