//
//  Created by Petr Chmelar on 20.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Resolver
import SwiftUI

final class LoginViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies

    private weak var flowController: FlowController?
    
    @Injected private(set) var loginUseCase: LoginUseCase
    @Injected private(set) var trackAnalyticsEventUseCase: TrackAnalyticsEventUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
        
        if Environment.flavor == .debug && Environment.type == .alpha {
            state.email = "petr.chmelar@matee.cz"
            state.password = "11111111"
        }
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var email: String = ""
        var password: String = ""
        var loginButtonEnabled: Bool = true
        var alert: String = ""
    }
    
    // MARK: Intent

    enum Intent {
        case onAppear
        case onEmailChange(String)
        case onPasswordChange(String)
        case onLogin
        case onRegister
    }

    func intent(_ intent: Intent) {
        switch intent {
        case .onAppear: onAppear()
        case .onEmailChange(let email): onEmailChange(email)
        case .onPasswordChange(let password): onPasswordChange(password)
        case .onLogin: login()
        case .onRegister: register()
        }
    }
    
    // MARK: Private
    
    private func onAppear() {
        trackAnalyticsEventUseCase.execute(LoginEvent.screenAppear.analyticsEvent)
    }
    
    private func onEmailChange(_ email: String) {
        state.email = email
    }
    
    private func onPasswordChange(_ password: String) {
        state.password = password
    }

    private func login() {
        guard !state.email.isEmpty && !state.password.isEmpty else {
            state.alert = L10n.invalid_credentials
            return
        }

        Task {
            do {
                state.loginButtonEnabled = false
                state.alert = L10n.signing_in
                
                let data = LoginData(email: state.email, password: state.password)
                try await loginUseCase.execute(data).asSingle().value
                trackAnalyticsEventUseCase.execute(LoginEvent.loginButtonTap.analyticsEvent)
                flowController?.handleFlow(.login(.dismiss))
            } catch {
                state.loginButtonEnabled = true
                let messages = ErrorMessages([.httpUnathorized: L10n.invalid_credentials], defaultMessage: L10n.signing_failed)
                state.alert = error.toString(messages)
            }
        }
    }

    private func register() {
        trackAnalyticsEventUseCase.execute(LoginEvent.registerButtonTap.analyticsEvent)
        flowController?.handleFlow(.login(.showRegistration))
    }
}
