//
//  Created by Viktor Kaderabek on 27/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class ShadowView: UIView {

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
        layer.shadowColor = UIColorCompatible.systemGray4.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
    }

    // MARK: Additional methods
}
