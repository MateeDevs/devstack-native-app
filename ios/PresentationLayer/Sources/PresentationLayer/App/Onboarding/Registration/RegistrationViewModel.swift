//
//  Created by Petr Chmelar on 13.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Resolver
import SwiftUI

final class RegistrationViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies

    private weak var flowController: FlowController?
    
    @Injected private(set) var registrationUseCase: RegistrationUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var email: String = ""
        var password: String = ""
        var registerButtonLoading: Bool = false
        var alert: AlertData?
    }
    
    // MARK: Intent

    enum Intent {
        case changeEmail(String)
        case changePassword(String)
        case register
        case login
        case dismissAlert
    }

    @discardableResult
    func onIntent(_ intent: Intent) -> Task<Void, Never> {
        executeTask(Task {
            switch intent {
            case .changeEmail(let email): changeEmail(email)
            case .changePassword(let password): changePassword(password)
            case .register: await register()
            case .login: login()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: Private
    
    private func changeEmail(_ email: String) {
        state.email = email
    }
    
    private func changePassword(_ password: String) {
        state.password = password
    }
    
    private func register() async {
        guard !state.email.isEmpty && !state.password.isEmpty else {
            state.alert = .init(title: L10n.invalid_credentials)
            return
        }
        
        do {
            state.registerButtonLoading = true
            let data = RegistrationData(email: state.email, password: state.password, firstName: "Anonymous", lastName: "")
            try await registrationUseCase.execute(data)
            flowController?.handleFlow(.login(.dismiss))
        } catch {
            state.registerButtonLoading = false
            let messages = ErrorMessages([.httpConflict: L10n.register_view_email_already_exists], defaultMessage: L10n.signing_up_failed)
            state.alert = .init(title: error.toString(messages))
        }
    }

    private func login() {
        flowController?.handleFlow(.registration(.pop))
    }
    
    private func dismissAlert() {
        state.alert = nil
    }
}
