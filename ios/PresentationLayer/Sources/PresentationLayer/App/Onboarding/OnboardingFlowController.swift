//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

protocol OnboardingFlowControllerDelegate: AnyObject {
    func setupMain()
}

class OnboardingFlowController: FlowController {
    
    weak var delegate: OnboardingFlowControllerDelegate?
    
    override func setup() -> UIViewController {
        let vm = LoginViewModel(dependencies: dependencies)
        return LoginViewController.instantiate(fc: self, vm: vm)
    }
    
    override func handleFlow(_ flow: Flow) {
        switch flow {
        case .login(let loginFlow): handleLoginFlow(loginFlow)
        case .registration(let registrationFlow): handleRegistrationFlow(registrationFlow)
        default: ()
        }
    }
    
    override func dismiss() {
        super.dismiss()
        delegate?.setupMain()
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
        let vm = RegistrationViewModel(dependencies: dependencies)
        let vc = RegistrationViewController.instantiate(fc: self, vm: vm)
        navigationController.show(vc, sender: nil)
    }
}

// MARK: Registration flow
extension OnboardingFlowController {
    func handleRegistrationFlow(_ flow: Flow.Registration) {
        switch flow {
        case .popRegistration: popRegistration()
        }
    }
    
    private func popRegistration() {
        navigationController.popViewController(animated: true)
    }
}
