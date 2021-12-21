//
//  Created by Petr Chmelar on 24/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class LocalizedImageView: UIImageView {

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
        image = image?.imageFlippedForRightToLeftLayoutDirection()
    }

    // MARK: Additional methods
}
