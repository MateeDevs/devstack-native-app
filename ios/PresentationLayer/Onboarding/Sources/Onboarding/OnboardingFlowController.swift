//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

public protocol OnboardingFlowControllerDelegate: AnyObject {
    func setupMain()
}

public class OnboardingFlowController: FlowController {
    
    public weak var delegate: OnboardingFlowControllerDelegate?
    
    override public func setup() -> UIViewController {
        let vm = LoginViewModel(flowController: self)
        return BaseHostingController(rootView: LoginView(viewModel: vm))
    }
    
    override public func dismiss() {
        super.dismiss()
        delegate?.setupMain()
    }
}

extension OnboardingFlowController: FlowHandler {
    public enum Flow: Equatable {
        case login(Login)
        case registration(Registration)
        
        public enum Login: Equatable {
            case dismiss
            case showRegistration
        }
        
        public enum Registration: Equatable {
            case dismiss
            case pop
        }
    }
    
    public func handleFlow(_ flow: Flow) {
        switch flow {
        case .login(let loginFlow): handleLoginFlow(loginFlow)
        case .registration(let registrationFlow): handleRegistrationFlow(registrationFlow)
        }
    }
}

// MARK: Login flow
extension OnboardingFlowController {
    func handleLoginFlow(_ flow: Flow.Login) {
        switch flow {
        case .dismiss: dismiss()
        case .showRegistration: showRegistration()
        }
    }
    
    private func showRegistration() {
        let vm = RegistrationViewModel(flowController: self)
        let vc = BaseHostingController(rootView: RegistrationView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
}

// MARK: Registration flow
extension OnboardingFlowController {
    func handleRegistrationFlow(_ flow: Flow.Registration) {
        switch flow {
        case .dismiss: dismiss()
        case .pop: pop()
        }
    }
}
