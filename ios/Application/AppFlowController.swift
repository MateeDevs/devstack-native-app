//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Factory
import SharedDomain
import UIKit
import UIToolkit

final class AppFlowController: FlowController {
    
    func start() {
        setupAppearance()
        
        setupMain()
    }
    
    func setupMain() {
        let fc = MainFlowController(navigationController: navigationController)
        let rootVC = startChildFlow(fc)
        navigationController.viewControllers = [rootVC]
    }
    
    private func setupAppearance() {
        // Navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(AppTheme.Colors.navBarBackground)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(AppTheme.Colors.navBarTitle)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(AppTheme.Colors.navBarTitle)

        // Tab bar
        UITabBar.appearance().tintColor = UIColor(AppTheme.Colors.primaryColor)

        // UITextField
        UITextField.appearance().tintColor = UIColor(AppTheme.Colors.primaryColor)
    }
}
