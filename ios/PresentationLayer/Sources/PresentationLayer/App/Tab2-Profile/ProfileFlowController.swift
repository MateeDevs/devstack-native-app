//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

protocol ProfileFlowControllerDelegate: AnyObject {
    func presentOnboarding()
}

class ProfileFlowController: FlowController {
    
    weak var delegate: ProfileFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let profileVM = ProfileViewModel(dependencies: dependencies)
        let profileVC = ProfileViewController.instantiate(fc: self, vm: profileVM)
        let settingsVM = SettingsViewModel(dependencies: dependencies)
        let settingsVC = SettingsViewController.instantiate(fc: self, vm: settingsVM)
        return ProfileWrapperViewController.instantiate(viewControllers: [profileVC, settingsVC])
    }
    
    override func handleFlow(_ flow: Flow) {
        switch flow {
        case .profile(let profileFlow): handleProfileFlow(profileFlow)
        default: ()
        }
    }
}

// MARK: Profile flow
extension ProfileFlowController {
    func handleProfileFlow(_ flow: Flow.Profile) {
        switch flow {
        case .presentOnboarding: presentOnboarding()
        }
    }
    
    private func presentOnboarding() {
        delegate?.presentOnboarding()
    }
}
