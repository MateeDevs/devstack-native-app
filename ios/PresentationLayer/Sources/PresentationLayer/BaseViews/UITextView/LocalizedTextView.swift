//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

@IBDesignable class LocalizedTextView: UITextView {

    // MARK: UI components

    // MARK: Stored properties
    private(set) var placeholder: String?
    private(set) var defaultColor: UIColor?
    @IBInspectable var placeholderColor: UIColor = AppTheme.Colors.placeholder

    // MARK: Inits
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        placeholder = NSLocalizedString(text, bundle: .module, comment: "")
        text = placeholder
        
        defaultColor = textColor
        textColor = placeholderColor
    }

    // MARK: Additional methods
}
