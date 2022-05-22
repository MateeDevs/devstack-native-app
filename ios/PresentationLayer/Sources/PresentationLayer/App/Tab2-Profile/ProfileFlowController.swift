//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SwiftUI
import UIKit

extension Flow {
    enum Profile: Equatable {
        case presentOnboarding
    }
}

protocol ProfileFlowControllerDelegate: AnyObject {
    func presentOnboarding()
}

class ProfileFlowController: FlowController {
    
    weak var delegate: ProfileFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let vm = ProfileViewModel(flowController: self)
        return UIHostingController(rootView: ProfileView(viewModel: vm))
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
