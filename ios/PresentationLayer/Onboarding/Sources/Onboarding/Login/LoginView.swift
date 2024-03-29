//
//  Created by Petr Chmelar on 20.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain
import SwiftUI
import UIToolkit

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
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
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory
import Utilities

#Preview {
    Environment.locale = .init(identifier: "cs")
    Container.shared.registerUseCaseMocks()
        
    let vm = LoginViewModel(flowController: nil)
    return LoginView(viewModel: vm)
}
#endif
