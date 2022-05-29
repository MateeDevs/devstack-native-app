//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

public protocol ProfileFlowControllerDelegate: AnyObject {
    func presentOnboarding()
}

public class ProfileFlowController: FlowController {
    
    public weak var delegate: ProfileFlowControllerDelegate?
    
    override public func setup() -> UIViewController {
        let vm = ProfileViewModel(flowController: self)
        return BaseHostingController(rootView: ProfileView(viewModel: vm))
    }
}

extension ProfileFlowController: FlowHandler {
    public enum Flow: Equatable {
        case profile(Profile)
        
        public enum Profile: Equatable {
            case presentOnboarding
        }
    }
    
    public func handleFlow(_ flow: Flow) {
        switch flow {
        case .profile(let profileFlow): handleProfileFlow(profileFlow)
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
