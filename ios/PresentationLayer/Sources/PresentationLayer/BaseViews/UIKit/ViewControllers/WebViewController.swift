//
//  Created by Petr Chmelar on 05/02/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    
    // MARK: Stored properties
    private var url: URL
    private var shouldAddCookies: Bool = false
    
    // MARK: Inits
    init(url: URL, shouldAddCookies: Bool = false) {
        self.url = url
        self.shouldAddCookies = shouldAddCookies
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup web view
        let webView = WKWebView(frame: view.frame)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        // Add cookies
        if shouldAddCookies, let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie, completionHandler: nil)
            }
        }
        
        webView.load(URLRequest(url: url))
    }
}

extension WebViewController: WKNavigationDelegate {
}
