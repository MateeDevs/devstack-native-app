//
//  Created by Petr Chmelar on 13/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import UIKit

protocol MainFlowControllerDelegate: AnyObject {
    func presentOnboarding(animated: Bool, completion: (() -> Void)?)
}

class MainFlowController: FlowController, ProfileFlowControllerDelegate {
    
    weak var delegate: MainFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let main = MainTabBarController.instantiate()
        main.viewControllers = [setupUsersTab(), setupProfileTab(), setupCounterTab(), setupBooksTab()]
        return main
    }
    
    private func setupUsersTab() -> UINavigationController {
        let usersNC = BaseNavigationController()
        usersNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_1,
            image: Asset.Images.usersTabBar.image,
            tag: MainTab.users.rawValue
        )
        let usersFC = UsersFlowController(navigationController: usersNC, dependencies: dependencies)
        let usersRootVC = startChildFlow(usersFC)
        usersNC.viewControllers = [usersRootVC]
        return usersNC
    }
    
    private func setupBooksTab() -> UINavigationController {
        let booksNC = BaseNavigationController()
        booksNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_4,
            image: Asset.Images.usersTabBar.image,
            tag: MainTab.books.rawValue
        )
        let booksFC = BooksFlowController(navigationController: booksNC, dependencies: dependencies)
        let booksRootVC = startChildFlow(booksFC)
        booksNC.viewControllers = [booksRootVC]
        return booksNC
    }
    
    private func setupProfileTab() -> UINavigationController {
        let profileNC = BaseNavigationController()
        profileNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_2,
            image: Asset.Images.profileTabBar.image,
            tag: MainTab.profile.rawValue
        )
        let profileFC = ProfileFlowController(navigationController: profileNC, dependencies: dependencies)
        profileFC.delegate = self
        let profileRootVC = startChildFlow(profileFC)
        profileNC.viewControllers = [profileRootVC]
        return profileNC
    }
    
    private func setupCounterTab() -> UINavigationController {
        let counterNC = BaseNavigationController()
        counterNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_3,
            image: Asset.Images.counterTabBar.image,
            tag: MainTab.counter.rawValue
        )
        let counterFC = CounterFlowController(navigationController: counterNC, dependencies: dependencies)
        let counterRootVC = startChildFlow(counterFC)
        counterNC.viewControllers = [counterRootVC]
        return counterNC
    }
    
    func presentOnboarding() {
        delegate?.presentOnboarding(animated: true, completion: { [weak self] in
            self?.navigationController.viewControllers = []
            self?.stopFlow()
        })
    }
    
    @discardableResult private func switchTab(_ index: MainTab) -> FlowController? {
        guard let tabController = rootViewController as? MainTabBarController,
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
        usersFlowController.handleUsersFlow(.showUserDetailForId(userId))
    }
}
