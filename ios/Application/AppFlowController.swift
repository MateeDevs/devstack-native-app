//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import UIKit
import UIToolkit

final class AppFlowController: FlowController, MainFlowControllerDelegate {
    
    @Injected private var handlePushNotificationUseCase: HandlePushNotificationUseCase
    
    func start() {
        setupAppearance()
        setupMain()
    }
    
    func setupMain() {
        let fc = MainFlowController(navigationController: navigationController)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        navigationController.navigationBar.isHidden = true
        navigationController.viewControllers = [rootVC]
    }
    
    func presentOnboarding(animated: Bool, completion: (() -> Void)?) {
        #warning("TODO: present onboarding (MainFlowControllerDelegate)")
    }
    
    public func handlePushNotification(_ notification: [AnyHashable: Any]) {
        guard let main = childControllers.first(where: { $0 is MainFlowController }) as? MainFlowController else { return }
        do {
            let notification = try handlePushNotificationUseCase.execute(notification)
            main.handleDeeplink(for: notification)
        } catch {}
    }
    
    public func handleLogout() {
        #warning("TODO: handleLogout for AppDelegate")
//        guard let vc = navigationController.topViewController as? BaseViewController else { return }
//
//        let action = AlertData.Action(title: L10n.dialog_interceptor_button_title, style: .default, handler: {
//            do {
//                // Perform logout and present login screen
//                try self.logoutUseCase.execute()
//                self.presentOnboarding(animated: true, completion: nil)
//            } catch {}
//        })
//
//        let alert = AlertData(title: L10n.dialog_interceptor_title, message: L10n.dialog_interceptor_text, primaryAction: action)
//        vc.handleAlertAction(.showAlert(alert))
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
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(AppTheme.Colors.primaryColor)]
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(AppTheme.Colors.primaryColor.opacity(0.5))]
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(AppTheme.Colors.primaryColor)
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(AppTheme.Colors.primaryColor.opacity(0.5))
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        // UITextField
        UITextField.appearance().tintColor = UIColor(AppTheme.Colors.primaryColor)
    }
}
