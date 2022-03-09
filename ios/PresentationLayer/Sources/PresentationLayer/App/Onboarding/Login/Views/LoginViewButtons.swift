//
//  Created by Petr Chmelar on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct LoginViewButtons: View {
    
    private let loginButtonLoading: Bool
    private let onLoginButtonTap: () -> Void
    private let onRegisterButtonTap: () -> Void
    
    init(
        loginButtonLoading: Bool,
        onLoginButtonTap: @escaping () -> Void,
        onRegisterButtonTap: @escaping () -> Void
    ) {
        self.loginButtonLoading = loginButtonLoading
        self.onLoginButtonTap = onLoginButtonTap
        self.onRegisterButtonTap = onRegisterButtonTap
    }
    
    var body: some View {
        VStack {
            Button(L10n.login_view_login_button_title) {
                onLoginButtonTap()
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: loginButtonLoading))
            .disabled(loginButtonLoading)
            
            Button(L10n.login_view_register_button_title) {
                onRegisterButtonTap()
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding()
    }
}

#if DEBUG
struct LoginViewButtons_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewButtons(
            loginButtonLoading: false,
            onLoginButtonTap: {},
            onRegisterButtonTap: {}
        )
    }
}
#endif
