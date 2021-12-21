//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import RxSwift
import UIKit

extension Flow {
    enum Login {
        case dismiss
        case showRegistration
    }
}

final class LoginViewController: InputViewController {
    
    // MARK: FlowController
    private weak var flowController: FlowController?
    
    // MARK: ViewModels
    private var viewModel: LoginViewModel?
    
    // MARK: UI components
    @IBOutlet private weak var emailTextField: TextFieldWithHint! {
        didSet {
            emailTextField.type = .email
        }
    }
    @IBOutlet private weak var passwordTextField: TextFieldWithHint! {
        didSet {
            passwordTextField.type = .password
        }
    }
    @IBOutlet private weak var loginButton: PrimaryButton!
    @IBOutlet private weak var registerButton: SecondaryButton!
    
    // MARK: Stored properties
    
    // MARK: Inits
    static func instantiate(fc: FlowController, vm: LoginViewModel) -> LoginViewController {
        let vc = StoryboardScene.Login.initialScene.instantiate()
        vc.flowController = fc
        vc.viewModel = vm
        vc.trackScreenAppear = vm.trackScreenAppear
        return vc
    }
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Environment.flavor == .debug && Environment.type == .alpha {
            emailTextField.textField.text = "petr.chmelar@matee.cz"
            passwordTextField.textField.text = "11111111"
        }
    }
    
    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        guard let viewModel = viewModel, let flowController = flowController else { return }

        // Inputs
        emailTextField.rx.text.bind(to: viewModel.input.email).disposed(by: disposeBag)
        passwordTextField.rx.text.bind(to: viewModel.input.password).disposed(by: disposeBag)
        loginButton.rx.tap.bind(to: viewModel.input.loginButtonTaps).disposed(by: disposeBag)
        registerButton.rx.tap.bind(to: viewModel.input.registerButtonTaps).disposed(by: disposeBag)

        // Outputs
        viewModel.output.loginButtonEnabled.drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.output.alertAction.drive(rx.alertAction).disposed(by: disposeBag)
        viewModel.output.flow.map { Flow.login($0) }.drive(flowController.rx.handleFlow).disposed(by: disposeBag)
    }

    // MARK: Additional methods

}
