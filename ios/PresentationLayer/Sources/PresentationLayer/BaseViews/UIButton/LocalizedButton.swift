//
//  Created by Viktor Kaderabek on 21/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

class LocalizedButton: StateButton {

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
        for state in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.selected, UIControl.State.disabled] {
            if let title = title(for: state) {
                setTitle(NSLocalizedString(title, bundle: .module, comment: ""), for: state)
            }
        }
        
        // Change alignment for right to left languages
        if contentHorizontalAlignment == .right && UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
            contentHorizontalAlignment = .left
        }
    }

    // MARK: Additional methods
}
