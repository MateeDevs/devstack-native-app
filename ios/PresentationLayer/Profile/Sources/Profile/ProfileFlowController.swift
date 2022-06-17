//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

enum ProfileFlow: Flow, Equatable {
    case profile(Profile)
    case editProfile(EditProfile)
    
    enum Profile: Equatable {
        case presentOnboarding
        case showEdit
    }
    
    enum EditProfile: Equatable {
        case dismiss
        case pop
    }
}

public protocol ProfileFlowControllerDelegate: AnyObject {
    func presentOnboarding()
}

public final class ProfileFlowController: FlowController {
    
    public weak var delegate: ProfileFlowControllerDelegate?
    
    override public func setup() -> UIViewController {
        let vm = ProfileViewModel(flowController: self)
        return BaseHostingController(rootView: ProfileView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let profileFlow = flow as? ProfileFlow else { return }
        switch profileFlow {
        case .profile(let profileFlow): handleProfileFlow(profileFlow)
        case .editProfile(let editProfileFlow): handleEditProfileFlow(editProfileFlow)
        }
    }
}

// MARK: Profile flow
extension ProfileFlowController {
    func handleProfileFlow(_ flow: ProfileFlow.Profile) {
        switch flow {
        case .presentOnboarding: presentOnboarding()
        case .showEdit: showEdit()
        }
    }
    
    private func presentOnboarding() {
        delegate?.presentOnboarding()
    }
    
    private func showEdit() {
        let vm = EditProfileViewModel(flowController: self)
        let vc = BaseHostingController(rootView: EditProfileView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
}

// MARK: EditProfile flow
extension ProfileFlowController {
    func handleEditProfileFlow(_ flow: ProfileFlow.EditProfile) {
        switch flow {
        case .dismiss: dismiss()
        case .pop: pop()
        }
    }
}
