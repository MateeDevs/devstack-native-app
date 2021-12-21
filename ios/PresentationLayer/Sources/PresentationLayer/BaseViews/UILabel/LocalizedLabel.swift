//
//  Created by Viktor Kaderabek on 21/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

@IBDesignable class LocalizedLabel: UILabel {

    // MARK: UI components

    // MARK: Stored properties
    @IBInspectable var requiredSymbol: String?
    @IBInspectable var uppercased: Bool = false

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
        if let text = text {
            if uppercased {
                self.text = NSLocalizedString(text, bundle: .module, comment: "").uppercased()
            } else {
                self.text = NSLocalizedString(text, bundle: .module, comment: "")
            }
            
            if let symbol = requiredSymbol {
                self.text = text + " " + symbol
            }
        }
        
        // Change alignment for right to left languages
        if textAlignment == .right && UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
            textAlignment = .left
        }
    }

    // MARK: Additional methods
}
