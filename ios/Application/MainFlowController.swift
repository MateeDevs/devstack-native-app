//
//  Created by Petr Chmelar on 13/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Sample
import SampleSharedViewModel
import SharedDomain
import SwiftUI
import UIKit
import UIToolkit

enum MainTab: Int {
    case sample = 0
    case sampleSharedViewModel = 1
}

final class MainFlowController: FlowController {
    
    override func setup() -> UIViewController {
        let main = UITabBarController()
        main.viewControllers = [setupSampleTab(), setupSampleSharedViewModelTab()]
        return main
    }
    
    private func setupSampleTab() -> UINavigationController {
        let sampleNC = BaseNavigationController(statusBarStyle: .lightContent)
        sampleNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_1,
            image: UIImage(systemName: "person.fill"),
            tag: MainTab.sample.rawValue
        )
        let sampleFC = SampleFlowController(navigationController: sampleNC)
        let sampleRootVC = startChildFlow(sampleFC)
        sampleNC.viewControllers = [sampleRootVC]
        return sampleNC
    }
    
    private func setupSampleSharedViewModelTab() -> UINavigationController {
        let sampleSharedViewModelNC = BaseNavigationController(statusBarStyle: .lightContent)
        sampleSharedViewModelNC.tabBarItem = UITabBarItem(
            title: L10n.bottom_bar_item_2,
            image: UIImage(systemName: "person.circle.fill"),
            tag: MainTab.sampleSharedViewModel.rawValue
        )
        let sampleSharedViewModelFC = SampleSharedViewModelFlowController(navigationController: sampleSharedViewModelNC)
        let sampleSharedViewModelRootVC = startChildFlow(sampleSharedViewModelFC)
        sampleSharedViewModelNC.viewControllers = [sampleSharedViewModelRootVC]
        return sampleSharedViewModelNC
    }
    
    @discardableResult private func switchTab(_ index: MainTab) -> FlowController? {
        guard let tabController = rootViewController as? UITabBarController,
            let tabs = tabController.viewControllers, index.rawValue < tabs.count else { return nil }
        tabController.selectedIndex = index.rawValue
        return childControllers[index.rawValue]
    }
}
