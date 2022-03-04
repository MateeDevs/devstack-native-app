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
            LoginViewFields(
                email: viewModel.state.email,
                password: viewModel.state.password,
                onEmailChange: { email in viewModel.intent(.onEmailChange(email)) },
                onPasswordChange: { password in viewModel.intent(.onPasswordChange(password)) }
            )
            Spacer()
            LoginViewButtons(
                loginButtonLoading: viewModel.state.loginButtonLoading,
                onLoginButtonTap: { viewModel.intent(.onLoginButtonTap) },
                onRegisterButtonTap: { viewModel.intent(.onRegisterButtonTap) }
            )
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.intent(.onAlertDismiss) }
        )) { alert in .init(alert) }
        .onAppear {
            viewModel.intent(.onAppear)
        }
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
