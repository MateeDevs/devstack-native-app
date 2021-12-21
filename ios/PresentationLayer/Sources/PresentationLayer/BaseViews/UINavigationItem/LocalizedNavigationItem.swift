//
//  Created by Viktor Kaderabek on 13/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

class LocalizedNavigationItem: UINavigationItem {

    // MARK: UI components

    // MARK: Stored properties

    // MARK: Inits
    override init(title: String) {
        super.init(title: title)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        if let title = title {
            self.title = NSLocalizedString(title, bundle: .module, comment: "")
        }
        
        if let backButtonTitle = backBarButtonItem?.title {
            self.backBarButtonItem?.title = NSLocalizedString(backButtonTitle, bundle: .module, comment: "")
        }
        
        if let prompt = prompt {
            self.prompt = NSLocalizedString(prompt, bundle: .module, comment: "")
        }
    }

    // MARK: Additional methods
}
