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
        var loginButtonLoading: Bool = false
        var alert: AlertData?
    }
    
    // MARK: Intent

    enum Intent {
        case onAppear
        case onAlertDismiss
        case onEmailChange(String)
        case onPasswordChange(String)
        case onLoginButtonTap
        case onRegisterButtonTap
    }

    @discardableResult
    func intent(_ intent: Intent) -> Task<Void, Never> {
        return Task {
            switch intent {
            case .onAppear: onAppear()
            case .onAlertDismiss: onAlertDismiss()
            case .onEmailChange(let email): onEmailChange(email)
            case .onPasswordChange(let password): onPasswordChange(password)
            case .onLoginButtonTap: await onLoginButtonTap()
            case .onRegisterButtonTap: onRegisterButtonTap()
            }
        }
    }
    
    // MARK: Private
    
    private func onAppear() {
        trackAnalyticsEventUseCase.execute(LoginEvent.screenAppear.analyticsEvent)
    }
    
    private func onAlertDismiss() {
        state.alert = nil
    }
    
    private func onEmailChange(_ email: String) {
        state.email = email
    }
    
    private func onPasswordChange(_ password: String) {
        state.password = password
    }

    private func onLoginButtonTap() async {
        guard !state.email.isEmpty && !state.password.isEmpty else {
            state.alert = .init(title: L10n.invalid_credentials)
            return
        }
        
        do {
            state.loginButtonLoading = true
            let data = LoginData(email: state.email, password: state.password)
            try await loginUseCase.execute(data)
            trackAnalyticsEventUseCase.execute(LoginEvent.loginButtonTap.analyticsEvent)
            flowController?.handleFlow(.login(.dismiss))
        } catch {
            state.loginButtonLoading = false
            let messages = ErrorMessages([.httpUnathorized: L10n.invalid_credentials], defaultMessage: L10n.signing_failed)
            state.alert = .init(title: error.toString(messages))
        }
    }

    private func onRegisterButtonTap() {
        trackAnalyticsEventUseCase.execute(LoginEvent.registerButtonTap.analyticsEvent)
        flowController?.handleFlow(.login(.showRegistration))
    }
}
