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
            VStack(alignment: .leading, spacing: 16) {
                HeadlineText(L10n.login_view_headline_title)
                    .padding(.top, 32)
                
                PrimaryTextField(L10n.login_view_email_field_hint, text: Binding<String>(
                    get: { viewModel.state.email },
                    set: { email in viewModel.intent(.onEmailChange(email)) }
                ))
                .keyboardType(.emailAddress)
                
                PrimaryTextField(L10n.login_view_password_field_hint, text: Binding<String>(
                    get: { viewModel.state.password },
                    set: { password in viewModel.intent(.onPasswordChange(password)) }
                ), secure: true)
            }
            .padding()
            
            Spacer()
            
            VStack {
                Button(L10n.login_view_login_button_title) {
                    viewModel.intent(.onLogin)
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(!viewModel.state.loginButtonEnabled)
                
                Button(L10n.login_view_register_button_title) {
                    viewModel.intent(.onRegister)
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            .padding()
            
            Text(viewModel.state.alert)
        }
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
