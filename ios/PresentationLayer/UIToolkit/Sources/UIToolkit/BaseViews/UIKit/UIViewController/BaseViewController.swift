//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import OSLog
import UIKit
import Utilities

public class BaseViewController: UIViewController {
    
    // MARK: Inits
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        Logger.lifecycle.info("\(type(of: self)) initialized")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger.lifecycle.info("\(type(of: self)) initialized")
    }
    
    deinit {
        Logger.lifecycle.info("\(type(of: self)) deinitialized")
    }
    
    // MARK: Lifecycle methods
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Default methods
    
    /// Override this method in a subclass and setup the view appearance
    open func setupUI() {
        // Setup background color and back button title
        view.backgroundColor = UIColor(AppTheme.Colors.background)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: L10n.back, style: .plain, target: nil, action: nil)
    }
}
