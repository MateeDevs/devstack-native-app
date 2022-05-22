//
//  Created by Petr Chmelar on 20.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            EmailAndPasswordFields(
                email: viewModel.state.email,
                password: viewModel.state.password,
                onEmailChange: { email in viewModel.onIntent(.changeEmail(email)) },
                onPasswordChange: { password in viewModel.onIntent(.changePassword(password)) }
            )
            Spacer()
            PrimaryAndSecondaryButtons(
                primaryButtonTitle: L10n.login_view_login_button_title,
                primaryButtonLoading: viewModel.state.loginButtonLoading,
                onPrimaryButtonTap: { viewModel.onIntent(.login) },
                secondaryButtonTitle: L10n.login_view_register_button_title,
                onSecondaryButtonTap: { viewModel.onIntent(.register) }
            )
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.onIntent(.dismissAlert) }
        )) { alert in .init(alert) }
        .lifecycle(viewModel)
    }
}

#if DEBUG
import Resolver

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        DomainLayer.Environment.locale = .init(identifier: "cs")
        Resolver.registerUseCasesForPreviews()
        
        let vm = LoginViewModel(flowController: nil)
        return PreviewGroup {
            LoginView(viewModel: vm)
        }
    }
}
#endif
