//
//  Created by Petr Chmelar on 20.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain
import SwiftUI
import UIToolkit
import DevstackKmpShared
import Combine

@MainActor
public extension View {
    @inlinable func bindViewModel<S: VmState, I: VmIntent>(_ viewModel: MyBaseViewModel<S, I>, stateBinding: Binding<S>) -> some View {
        var task: Task<(), Error>? = nil
        @Binding var state: S
        _state = stateBinding
        return self
            .onAppear {
                task = Task {
                    for try await newState: S in viewModel.asyncStreamFromState() {
                        state = newState
                    }
                }
            }
            .onDisappear {
                task?.cancel()
                viewModel.onCleared()
            }
    }
}

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    @Injected private var testViewModel: TestViewModel
    
    @State private var state: TestViewModel.ViewState
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        self.state = .init(loading: false, email: "", password: "", testNumber: 0)
    }
    
    var body: some View {
        VStack {
            Text("Test number: \(state.testNumber)")
            
            EmailAndPasswordFields(
                title: L10n.login_view_headline_title,
                email: viewModel.state.email,
                password: viewModel.state.password,
                onEmailChange: { email in viewModel.onIntent(.changeEmail(email)) },
                onPasswordChange: { password in viewModel.onIntent(.changePassword(password)) }
            )
            Spacer()
            InfoErrorSnackHost(snackState: viewModel.snackState)
            PrimaryAndSecondaryButtons(
                primaryButtonTitle: L10n.login_view_login_button_title,
                onPrimaryButtonTap: { viewModel.onIntent(.login) },
                secondaryButtonTitle: L10n.login_view_register_button_title,
                onSecondaryButtonTap: { viewModel.onIntent(.register) }
            )
        }
        .animation(.default)
        .environment(\.isLoading, viewModel.state.isLoading)
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.onIntent(.dismissAlert) }
        )) { alert in .init(alert) }
        .lifecycle(viewModel)
        .onAppear {
            testViewModel.onIntent(intent: TestViewModelViewIntentOnViewAppeared())
        }
        .bindViewModel(testViewModel, stateBinding: self.$state)
    }
}

#if DEBUG
import Resolver
import SharedDomainMocks
import Utilities

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Environment.locale = .init(identifier: "cs")
        Resolver.registerUseCaseMocks()
        
        let vm = LoginViewModel(flowController: nil)
        return PreviewGroup {
            LoginView(viewModel: vm)
        }
    }
}
#endif
