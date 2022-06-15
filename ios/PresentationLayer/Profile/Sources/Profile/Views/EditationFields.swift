//
//  Created by David Sobisek on 15.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct EditationFields: View {
    
    private let name: String
    private let email: String
    private let password: String
    private let bio: String
    private let onNameChange: (String) -> Void
    private let onEmailChange: (String) -> Void
    private let onPasswordChange: (String) -> Void
    private let onBioChange: (String) -> Void
    
    init(
        name: String,
        email: String,
        password: String,
        bio: String,
        onNameChange: @escaping (String) -> Void,
        onEmailChange: @escaping (String) -> Void,
        onPasswordChange: @escaping (String) -> Void,
        onBioChange: @escaping (String) -> Void
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.bio = bio
        self.onNameChange = onNameChange
        self.onEmailChange = onEmailChange
        self.onPasswordChange = onPasswordChange
        self.onBioChange = onBioChange
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            PrimaryTextField(
                "Name",
                text: Binding<String>(
                    get: { name },
                    set: { name in onNameChange(name) }
                )
            )
            
            Spacer()
            
            PrimaryTextField(
                "Email",
                text: Binding<String>(
                    get: { email },
                    set: { email in onEmailChange(email) }
                )
            )
            
            Spacer()
            
            PrimaryTextField(
                "Password",
                text: Binding<String>(
                    get: { password },
                    set: { password in onPasswordChange(password) }
                ),
                secure: true
            )
            
            Spacer()
            
            PrimaryTextField(
                "Bio",
                text: Binding<String>(
                    get: { bio },
                    set: { bio in onBioChange(bio) }
                )
            )
        }
        .padding()
    }
}

#if DEBUG
struct EditationFields_Previews: PreviewProvider {
    static var previews: some View {
        EditationFields(name: "David",
                        email: "ds@gmail.com",
                        password: "password",
                        bio: "BIO",
                        onNameChange: {_ in},
                        onEmailChange: {_ in},
                        onPasswordChange: {_ in},
                        onBioChange: {_ in}
        )
    }
}
#endif
