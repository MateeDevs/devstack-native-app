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
            Text("Sign in")
            
            TextField("Email", text: Binding<String>(
                get: { viewModel.state.email },
                set: { email in viewModel.intent(.onEmailChange(email)) }
            ))
            
            TextField("Password", text: Binding<String>(
                get: { viewModel.state.password },
                set: { password in viewModel.intent(.onPasswordChange(password)) }
            ))
            
            Button("Login") { viewModel.intent(.onLogin)}
                .disabled(!viewModel.state.loginButtonEnabled)
            
            Button("Register") { viewModel.intent(.onRegister) }
            
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
        Resolver.registerUseCasesForPreviews()
        
        let vm = LoginViewModel(flowController: nil)
        return Group {
            LoginView(viewModel: vm)
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            LoginView(viewModel: vm)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        }
    }
}
#endif
