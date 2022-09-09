//
//  Created by Petr Chmelar on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct UserEditProfileFields: View {
    
    private let title: String
    private let firstName: String
    private let lastName: String
    private let phone: String
    private let bio: String
    private let onFirstNameChange: (String) -> Void
    private let onLastNameChange: (String) -> Void
    private let onPhoneChange: (String) -> Void
    private let onBioChange: (String) -> Void
    
    init(
        title: String,
        firstName: String,
        lastName: String,
        phone: String,
        bio: String,
        onFirstNameChange: @escaping (String) -> Void,
        onLastNameChange: @escaping (String) -> Void,
        onPhoneChange: @escaping (String) -> Void,
        onBioChange: @escaping (String) -> Void
    ) {
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.bio = bio
        self.onFirstNameChange = onFirstNameChange
        self.onLastNameChange = onLastNameChange
        self.onPhoneChange = onPhoneChange
        self.onBioChange = onBioChange
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HeadlineText(title)
                .padding(.top, 32)
            
            PrimaryTextField(
                "First Name",
                text: Binding<String>(
                    get: { firstName },
                    set: { firstName in onFirstNameChange(firstName) }
                )
            )
            
            PrimaryTextField(
                "Last Name",
                text: Binding<String>(
                    get: { lastName },
                    set: { lastName in onLastNameChange(lastName) }
                )
            )
            
            PrimaryTextField(
                "Phone",
                text: Binding<String>(
                    get: { phone },
                    set: { phone in onPhoneChange(phone) }
                )
            ).keyboardType(.phonePad)
        }
        .padding()
    }
}

#if DEBUG
struct UserEditProfileFields_Previews: PreviewProvider {
    static var previews: some View {
        UserEditProfileFields(
            title: "Edit",
            firstName: "Adam",
            lastName: "Penaz",
            phone: "111 233 344",
            bio: "Basic bio",
            onFirstNameChange: { _ in },
            onLastNameChange: { _ in },
            onPhoneChange: { _ in },
            onBioChange: { _ in }
        )
    }
}
#endif
