//
//  Created by Petr Chmelar on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct EmailAndPasswordFields: View {
    
    private let title: String
    private let email: String
    private let password: String
    private let onEmailChange: (String) -> Void
    private let onPasswordChange: (String) -> Void
    
    init(
        title: String,
        email: String,
        password: String,
        onEmailChange: @escaping (String) -> Void,
        onPasswordChange: @escaping (String) -> Void
    ) {
        self.title = title
        self.email = email
        self.password = password
        self.onEmailChange = onEmailChange
        self.onPasswordChange = onPasswordChange
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeadlineText(title)
                .padding(.top, 32)
            
            PrimaryTextField(
                L10n.login_view_email_field_hint,
                text: Binding<String>(
                    get: { email },
                    set: { email in onEmailChange(email) }
                )
            ).keyboardType(.emailAddress)
            
            PrimaryTextField(
                L10n.login_view_password_field_hint,
                text: Binding<String>(
                    get: { password },
                    set: { password in onPasswordChange(password) }
                ),
                secure: true
            )
        }
        .padding()
    }
}

#if DEBUG
#Preview {
    EmailAndPasswordFields(
        title: "Sign in",
        email: "abc@abc.cz",
        password: "1111",
        onEmailChange: { _ in },
        onPasswordChange: { _ in }
    )
}
#endif
