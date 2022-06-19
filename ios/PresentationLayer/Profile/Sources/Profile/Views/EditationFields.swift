//
//  Created by David Sobisek on 15.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct EditationFields: View {
    
    private let firstName: String
    private let lastName: String
    private let email: String
    private let phone: String
    private let bio: String
    private let onFirstNameChange: (String) -> Void
    private let onLastNameChange: (String) -> Void
    private let onEmailChange: (String) -> Void
    private let onPhoneChange: (String) -> Void
    private let onBioChange: (String) -> Void
    
    init(
        firstName: String,
        lastName: String,
        email: String,
        phone: String,
        bio: String,
        onFirstNameChange: @escaping (String) -> Void,
        onLastNameChange: @escaping (String) -> Void,
        onEmailChange: @escaping (String) -> Void,
        onPhoneChange: @escaping (String) -> Void,
        onBioChange: @escaping (String) -> Void
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.bio = bio
        self.onFirstNameChange = onFirstNameChange
        self.onLastNameChange = onLastNameChange
        self.onEmailChange = onEmailChange
        self.onPhoneChange = onPhoneChange
        self.onBioChange = onBioChange
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            PrimaryTextField(
                "First Name",
                text: Binding<String>(
                    get: { firstName },
                    set: { firstName in onFirstNameChange(firstName) }
                )
            ).keyboardType(.namePhonePad)
            
            PrimaryTextField(
                "Last Name",
                text: Binding<String>(
                    get: { lastName },
                    set: { lastName in onLastNameChange(lastName) }
                )
            ).keyboardType(.namePhonePad)
            
            PrimaryTextField(
                "Email",
                text: Binding<String>(
                    get: { email },
                    set: { email in onEmailChange(email) }
                )
            ).keyboardType(.emailAddress)
            
            PrimaryTextField(
                "Phone",
                text: Binding<String>(
                    get: { phone },
                    set: { phone in onPhoneChange(phone) }
                )
            ).keyboardType(.phonePad)
            
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
        EditationFields(firstName: "David",
                        lastName: "Sobisek",
                        email: "ds@gmail.com",
                        phone: "phone",
                        bio: "BIO",
                        onFirstNameChange: { _ in },
                        onLastNameChange: { _ in },
                        onEmailChange: { _ in },
                        onPhoneChange: { _ in },
                        onBioChange: { _ in }
        )
    }
}
#endif
