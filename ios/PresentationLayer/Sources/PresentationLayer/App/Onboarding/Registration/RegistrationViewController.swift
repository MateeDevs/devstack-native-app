//
//  Created by Petr Chmelar on 05/03/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import UIKit

extension Flow {
    enum Registration {
        case popRegistration
    }
}

final class RegistrationViewController: InputViewController {

    // MARK: FlowController
    private weak var flowController: FlowController?

    // MARK: ViewModels
    private var viewModel: RegistrationViewModel?

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
    @IBOutlet private weak var registerButton: PrimaryButton!
    @IBOutlet private weak var loginButton: SecondaryButton!

    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(fc: FlowController, vm: RegistrationViewModel) -> RegistrationViewController {
        let vc = StoryboardScene.Registration.initialScene.instantiate()
        vc.flowController = fc
        vc.viewModel = vm
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        guard let viewModel = viewModel, let flowController = flowController else { return }

        // Inputs
        emailTextField.rx.text.bind(to: viewModel.input.email).disposed(by: disposeBag)
        passwordTextField.rx.text.bind(to: viewModel.input.password).disposed(by: disposeBag)
        registerButton.rx.tap.bind(to: viewModel.input.registerButtonTaps).disposed(by: disposeBag)
        loginButton.rx.tap.bind(to: viewModel.input.loginButtonTaps).disposed(by: disposeBag)

        // Outputs
        viewModel.output.registerButtonEnabled.drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.output.alertAction.drive(rx.alertAction).disposed(by: disposeBag)
        viewModel.output.flow.map { Flow.registration($0) }.drive(flowController.rx.handleFlow).disposed(by: disposeBag)
    }

    // MARK: Additional methods

}
