//
//  Created by Petr Chmelar on 19/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class HeadlineLabel: LocalizedLabel {

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
        textColor = AppTheme.Colors.headlineLabel
        font = AppTheme.Fonts.headlineLabel
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
    }

    // MARK: Additional methods
}
