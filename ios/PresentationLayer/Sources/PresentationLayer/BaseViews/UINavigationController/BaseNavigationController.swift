//
//  Created by Petr Chmelar on 06.10.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import UIKit

public class BaseNavigationController: UINavigationController {
    
    private var statusBarStyle: UIStatusBarStyle = .default
    
    public convenience init(statusBarStyle: UIStatusBarStyle) {
        self.init(nibName: nil, bundle: nil)
        self.statusBarStyle = statusBarStyle
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}
