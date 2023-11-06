//
//  Created by Petr Chmelar on 13.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit

final class RegistrationViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.registrationUseCase) private(set) var registrationUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var email: String = ""
        var password: String = ""
        var isLoading: Bool = false
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

    func onIntent(_ intent: Intent) {
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
        do {
            state.isLoading = true
            let data = RegistrationData(email: state.email, password: state.password, firstName: "Anonymous", lastName: "")
            try await registrationUseCase.execute(data)
            flowController?.handleFlow(OnboardingFlow.registration(.dismiss))
        } catch {
            state.isLoading = false
            state.alert = .init(title: error.localizedDescription)
        }
    }

    private func login() {
        flowController?.handleFlow(OnboardingFlow.registration(.pop))
    }
    
    private func dismissAlert() {
        state.alert = nil
    }
}
