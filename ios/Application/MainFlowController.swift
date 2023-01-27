//
//  Created by Petr Chmelar on 13/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Freerun
import Home
import Profile
import SharedDomain
import UIKit
import UIToolkit

enum MainTab: Int {
    case home = 0
    case freerun = 1
    case profile = 2
}

protocol MainFlowControllerDelegate: AnyObject {
    func presentOnboarding(animated: Bool, completion: (() -> Void)?)
}

final class MainFlowController: FlowController {
    
    weak var delegate: MainFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let main = UITabBarController()
        main.viewControllers = [setupHomeTab(), setupFreerunTab(), setupProfileTab()]
        return main
    }
    
    private func setupHomeTab() -> UINavigationController {
        let homeNC = BaseNavigationController()
        homeNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_1,
            image: UIImage(systemName: AppTheme.Images.homeTab),
            tag: MainTab.home.rawValue
        )
        let homeFC = HomeFlowController(navigationController: homeNC)
        let homeRootVC = startChildFlow(homeFC)
        homeNC.navigationBar.isHidden = true
        homeNC.viewControllers = [homeRootVC]
        return homeNC
    }
    
    private func setupFreerunTab() -> UINavigationController {
        let freerunNC = BaseNavigationController()
        freerunNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_2,
            image: UIImage(systemName: AppTheme.Images.freerunTab),
            tag: MainTab.freerun.rawValue
        )
        let freerunFC = FreerunFlowController(navigationController: freerunNC)
        let freerunRootVC = startChildFlow(freerunFC)
        freerunNC.navigationBar.isHidden = true
        freerunNC.viewControllers = [freerunRootVC]
        return freerunNC
    }
    
    private func setupProfileTab() -> UINavigationController {
        let profileNC = BaseNavigationController()
        profileNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_3,
            image: UIImage(systemName: AppTheme.Images.profileTab),
            tag: MainTab.profile.rawValue
        )
        let profileFC = ProfileFlowController(navigationController: profileNC)
        let profileRootVC = startChildFlow(profileFC)
        profileNC.navigationBar.isHidden = true
        profileNC.viewControllers = [profileRootVC]
        return profileNC
    }
    
    func presentOnboarding() {
        delegate?.presentOnboarding(animated: true, completion: { [weak self] in
            self?.navigationController.viewControllers = []
            self?.stopFlow()
        })
    }
    
    @discardableResult private func switchTab(_ index: MainTab) -> FlowController? {
        guard let tabController = rootViewController as? UITabBarController,
            let tabs = tabController.viewControllers, index.rawValue < tabs.count else { return nil }
        tabController.selectedIndex = index.rawValue
        return childControllers[index.rawValue]
    }
    
    func handleDeeplink(for notification: PushNotification) {
        switch notification.type {
        case .userDetail:
            handleUserDetailDeeplink(userId: notification.entityId)
        default:
            return
        }
    }
    
    private func handleUserDetailDeeplink(userId: String) {
//        guard let usersFlowController = switchTab(.users) as? UsersFlowController else { return }
//        usersFlowController.handleUserDetailDeeplink(userId: userId)
    }
}
