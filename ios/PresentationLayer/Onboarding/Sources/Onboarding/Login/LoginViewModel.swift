//
//  Created by Petr Chmelar on 20.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit
import Utilities

final class LoginViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.loginUseCase) private(set) var loginUseCase
    @Injected(\.trackAnalyticsEventUseCase) private (set) var trackAnalyticsEventUseCase
    @Injected(\.requestFeedbackUseCase) private var requestFeedbackUseCase
    @Published private(set) var snackState = SnackState<InfoErrorSnackVisuals>()

    init(flowController: FlowController?) {
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
        var isLoading: Bool = false
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

    func onIntent(_ intent: Intent) {
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
            state.isLoading = true
            let data = LoginData(email: state.email, password: state.password)
            try await loginUseCase.execute(data)
            trackAnalyticsEventUseCase.execute(LoginEvent.loginButtonTap.analyticsEvent)
            
            snackState.currentData?.dismiss()
            await snackState.showSnack(.info(message: "Success", duration: 1))
            flowController?.handleFlow(OnboardingFlow.login(.dismiss))
            
            // We don't need to handle the error
            try? requestFeedbackUseCase.execute()
        } catch {
            state.isLoading = false
            snackState.currentData?.dismiss()
            await snackState.showSnack(
                .error(
                    message: error.localizedMessage,
                    actionLabel: nil
                )
            )
        }
    }

    private func register() {
        trackAnalyticsEventUseCase.execute(LoginEvent.registerButtonTap.analyticsEvent)
        flowController?.handleFlow(OnboardingFlow.login(.showRegistration))
    }
    
    private func dismissAlert() {
        state.alert = nil
    }
}
