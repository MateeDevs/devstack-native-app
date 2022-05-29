//
//  Created by Petr Chmelar on 13/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Profile
import Recipes
import SharedDomain
import UIKit
import UIToolkit
import Users

enum MainTab: Int {
    case users = 0
    case profile = 1
    case recipes = 2
}

protocol MainFlowControllerDelegate: AnyObject {
    func presentOnboarding(animated: Bool, completion: (() -> Void)?)
}

class MainFlowController: FlowController, ProfileFlowControllerDelegate {
    
    weak var delegate: MainFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let main = UITabBarController()
        main.viewControllers = [setupUsersTab(), setupProfileTab(), setupRecipesTab()]
        return main
    }
    
    private func setupUsersTab() -> UINavigationController {
        let usersNC = BaseNavigationController()
        usersNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_1,
            image: Asset.Images.usersTabBar.image,
            tag: MainTab.users.rawValue
        )
        let usersFC = UsersFlowController(navigationController: usersNC)
        let usersRootVC = startChildFlow(usersFC)
        usersNC.viewControllers = [usersRootVC]
        return usersNC
    }
    
    private func setupProfileTab() -> UINavigationController {
        let profileNC = BaseNavigationController()
        profileNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_2,
            image: Asset.Images.profileTabBar.image,
            tag: MainTab.profile.rawValue
        )
        let profileFC = ProfileFlowController(navigationController: profileNC)
        profileFC.delegate = self
        let profileRootVC = startChildFlow(profileFC)
        profileNC.viewControllers = [profileRootVC]
        return profileNC
    }
    
    private func setupRecipesTab() -> UINavigationController {
        let recipesNC = BaseNavigationController()
        recipesNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_3,
            image: Asset.Images.recipesTabBar.image,
            tag: MainTab.recipes.rawValue
        )
        let recipesFC = RecipesFlowController(navigationController: recipesNC)
        let recipesRootVC = startChildFlow(recipesFC)
        recipesNC.viewControllers = [recipesRootVC]
        return recipesNC
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
        guard let usersFlowController = switchTab(.users) as? UsersFlowController else { return }
        usersFlowController.handleFlow(.users(.showUserDetailForId(userId)))
    }
}
