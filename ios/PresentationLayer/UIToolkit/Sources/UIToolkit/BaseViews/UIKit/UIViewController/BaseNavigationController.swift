//
//  Created by Petr Chmelar on 06.10.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import UIKit

public final class BaseNavigationController: UINavigationController {
    
    private var statusBarStyle: UIStatusBarStyle = .default
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override public var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
    
    public convenience init(statusBarStyle: UIStatusBarStyle) {
        self.init(nibName: nil, bundle: nil)
        self.statusBarStyle = statusBarStyle
    }
}
