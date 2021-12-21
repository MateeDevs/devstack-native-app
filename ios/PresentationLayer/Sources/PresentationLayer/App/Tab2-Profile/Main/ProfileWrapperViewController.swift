//
//  Created by Petr Chmelar on 20/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

final class ProfileWrapperViewController: BaseViewController {

    // MARK: FlowController

    // MARK: ViewModels

    // MARK: UI components
    @IBOutlet private weak var tabBarView: TabBarView!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: Stored properties
    private var viewControllers: [BaseViewController] = []
    private var currentViewController: BaseViewController?

    // MARK: Inits
    static func instantiate(viewControllers: [BaseViewController]) -> ProfileWrapperViewController {
        let vc = StoryboardScene.ProfileWrapper.initialScene.instantiate()
        vc.viewControllers = viewControllers
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarView.delegate = self
        tabBarView.select(0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarView.configureViews()
    }

    // MARK: Default methods

    override func setupUI() {
        super.setupUI()
        
		navigationItem.title = L10n.profile_view_toolbar_title
        
        tabBarView.buttonBackgroundColor = AppTheme.Colors.primaryColor
        tabBarView.buttonBackgroundColorHighlighted = AppTheme.Colors.primaryColor
        tabBarView.buttonMainLabelColor = .white
        tabBarView.buttonMainLabelColorHighlighted = .white
        tabBarView.stripViewColor = .black
        tabBarView.availableOptions = [L10n.profile_view_tab_bar_profile_title, L10n.profile_view_tab_bar_settings_title]
    }

    // MARK: Additional methods

}

extension ProfileWrapperViewController: TabBarViewDelegate {
    func didSelectViewController(tag: Int) {
        if let controller = currentViewController {
            removeViewController(controller: controller)
        }
        
        currentViewController = viewControllers[tag]
        
        if let controller = currentViewController {
            addViewController(controller: controller)
        }
    }
    
    func removeViewController(controller: BaseViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
    
    func addViewController(controller: BaseViewController) {
        addChild(controller)
        containerView.addSubview(controller.view)
        controller.view.frame = containerView.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.didMove(toParent: self)
    }
}
