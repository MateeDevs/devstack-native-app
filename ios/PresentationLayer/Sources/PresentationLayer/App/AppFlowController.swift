//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import UIKit

public class AppFlowController: FlowController, MainFlowControllerDelegate, OnboardingFlowControllerDelegate {
    
    public func start() {
        setupAppearance()
        
        if dependencies.getProfileIdUseCase.execute() != nil {
            setupMain()
        } else {
            presentOnboarding(animated: false, completion: nil)
        }
    }
    
    func setupMain() {
        let fc = MainFlowController(navigationController: navigationController, dependencies: dependencies)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        navigationController.viewControllers = [rootVC]
    }
    
    func presentOnboarding(animated: Bool, completion: (() -> Void)?) {
        let nc = BaseNavigationController()
        let fc = OnboardingFlowController(navigationController: nc, dependencies: dependencies)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        nc.viewControllers = [rootVC]
        nc.modalPresentationStyle = .fullScreen
        nc.navigationBar.isHidden = true
        navigationController.present(nc, animated: animated, completion: completion)
    }
    
    public func handlePushNotification(_ notification: [AnyHashable: Any]) {
        guard let notification = dependencies.handlePushNotificationUseCase.execute(notification),
              let main = childControllers.first(where: { $0 is MainFlowController }) as? MainFlowController else { return }
        main.handleDeeplink(for: notification)
    }
    
    public func handleLogout() {
        guard let vc = navigationController.topViewController as? BaseViewController else { return }

        let action = UIAlertAction(title: L10n.dialog_interceptor_button_title, style: .default, handler: { _ in
            // Perform logout and present login screen
            self.dependencies.logoutUseCase.execute()
            self.presentOnboarding(animated: true, completion: nil)
        })

        let alert = Alert(title: L10n.dialog_interceptor_title, message: L10n.dialog_interceptor_text, primaryAction: action)
        vc.handleAlertAction(.showAlert(alert))
    }
    
    private func setupAppearance() {
        // Navigation bar
        UINavigationBar.appearance().tintColor = AppTheme.Colors.navBarTitle
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = AppTheme.Colors.navBarBackground
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppTheme.Colors.navBarTitle]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().barTintColor = AppTheme.Colors.navBarBackground
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppTheme.Colors.navBarTitle]
        }

        // Tab bar
        UITabBar.appearance().tintColor = AppTheme.Colors.primaryColor

        // UITextField
        UITextField.appearance().tintColor = AppTheme.Colors.primaryColor
    }
}
