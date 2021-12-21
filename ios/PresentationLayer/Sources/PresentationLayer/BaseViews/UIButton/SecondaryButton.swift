//
//  Created by Petr Chmelar on 04/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

class SecondaryButton: LocalizedButton {

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
        tintColor = AppTheme.Colors.secondaryButtonTitle
    }

    // MARK: Additional methods
}
