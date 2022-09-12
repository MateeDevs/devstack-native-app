//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

enum ProfileFlow: Flow, Equatable {
    case profile(Profile)
    case edit(Edit)
    
    enum Profile: Equatable {
        case presentOnboarding
        case showEditProfile
    }
    
    enum Edit: Equatable {
        case pop
        case dismiss
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
    
    override public func dismiss() {
        super.dismiss()
        delegate?.presentOnboarding()
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let profileFlow = flow as? ProfileFlow else { return }
        switch profileFlow {
        case .profile(let profileFlow): handleProfileFlow(profileFlow)
        case .edit(let editFlow): handleEditFlow(editFlow)
        }
    }
}

// MARK: Profile flow
extension ProfileFlowController {
    func handleProfileFlow(_ flow: ProfileFlow.Profile) {
        switch flow {
        case .presentOnboarding: presentOnboarding()
        case .showEditProfile: showEditProfile()
        }
    }
    
    private func presentOnboarding() {
        delegate?.presentOnboarding()
    }
    
    private func showEditProfile() {
        let vm = EditProfileViewModel(flowController: self)
        let view = EditProfileView(viewModel: vm)
        navigationController.show(BaseHostingController(rootView: view), sender: nil)
    }
}

// MARK: Edit flow
extension ProfileFlowController {
    func handleEditFlow(_ flow: ProfileFlow.Edit) {
        switch flow {
        case .pop: pop()
        case .dismiss: dismiss()
        }
    }
}
