//
//  Created by Petr Chmelar on 20.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import UIToolkit
import Utilities

final class LoginViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: OnboardingFlowController?
    
    @Injected private(set) var loginUseCase: LoginUseCase
    @Injected private(set) var trackAnalyticsEventUseCase: TrackAnalyticsEventUseCase

    init(flowController: OnboardingFlowController?) {
        self.flowController = flowController
        super.init()
        
        if Environment.flavor == .debug && Environment.type == .alpha {
            state.email = "petr.chmelar@matee.cz"
            state.password = "11111111"
        }
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        trackAnalyticsEventUseCase.execute(LoginEvent.screenAppear.analyticsEvent)
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
        case changeEmail(String)
        case changePassword(String)
        case login
        case register
        case dismissAlert
    }

    @discardableResult
    func onIntent(_ intent: Intent) -> Task<Void, Never> {
        executeTask(Task {
            switch intent {
            case .changeEmail(let email): changeEmail(email)
            case .changePassword(let password): changePassword(password)
            case .login: await login()
            case .register: register()
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

    private func login() async {
        do {
            state.loginButtonLoading = true
            let data = LoginData(email: state.email, password: state.password)
            try await loginUseCase.execute(data)
            trackAnalyticsEventUseCase.execute(LoginEvent.loginButtonTap.analyticsEvent)
            flowController?.handleFlow(.login(.dismiss))
        } catch {
            state.loginButtonLoading = false
            state.alert = .init(title: error.localizedDescription)
        }
    }

    private func register() {
        trackAnalyticsEventUseCase.execute(LoginEvent.registerButtonTap.analyticsEvent)
        flowController?.handleFlow(.login(.showRegistration))
    }
    
    private func dismissAlert() {
        state.alert = nil
    }
}
