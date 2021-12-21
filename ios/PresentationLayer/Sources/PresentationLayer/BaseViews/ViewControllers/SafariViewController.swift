//
//  Created by Petr Chmelar on 13/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SafariServices

class SafariViewController: SFSafariViewController {
    
    // MARK: Stored properties
    private let url: URL
    
    // MARK: Inits
    override init(url URL: URL, configuration: SFSafariViewController.Configuration = SFSafariViewController.Configuration()) {
        self.url = URL
        super.init(url: URL, configuration: configuration)
    }
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredControlTintColor = AppTheme.Colors.primaryColor
    }
    
    ///
    /// Try to open universal link
    ///
    /// - parameter completionHandler: Returns false for non universal link or when app is not installed
    ///
    func openUniversalLink(completionHandler completion: ((Bool) -> Void)? = nil) {
        UIApplication.shared.open(url, options: [.universalLinksOnly: true], completionHandler: completion)
    }
}
