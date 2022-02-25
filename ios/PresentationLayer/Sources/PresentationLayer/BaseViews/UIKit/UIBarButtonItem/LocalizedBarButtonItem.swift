//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class LocalizedBarButtonItem: UIBarButtonItem {

    // MARK: UI components
    
    // MARK: Stored properties

    // MARK: Inits
    override init() {
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        if let title = self.title {
            self.title = NSLocalizedString(title, bundle: .module, comment: "")
        }
    }

    // MARK: Additional methods
}
