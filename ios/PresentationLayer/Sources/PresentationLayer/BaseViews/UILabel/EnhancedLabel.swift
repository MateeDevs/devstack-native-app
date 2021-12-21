//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

@IBDesignable class EnhancedLabel: LocalizedLabel {

    // MARK: UI components

    // MARK: Stored properties
    @IBInspectable var charSpace: Double = 1.0 {
        didSet {
            reloadAttributedTitle()
        }
    }
    
    @IBInspectable var lineSpace: Double = 1.0 {
        didSet {
            reloadAttributedTitle()
        }
    }
    
    @IBInspectable var lineHeight: Double = 1.0 {
        didSet {
            reloadAttributedTitle()
        }
    }

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
    }

    // MARK: Additional methods
    private func reloadAttributedTitle() {
        guard let text = text else { return }
            
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineSpace)
        paragraphStyle.lineHeightMultiple = CGFloat(lineHeight)
            
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.kern: charSpace,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
            
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        attributedText = attributedString
    }
}
