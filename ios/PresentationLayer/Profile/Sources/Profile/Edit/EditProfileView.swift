//
//  Created by David Sobisek on 15.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct EditProfileView: View {
    @ObservedObject private var viewModel: EditProfileViewModel
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            EditationFields(name: viewModel.state.name,
                            email: viewModel.state.email,
                            password: viewModel.state.password,
                            bio: viewModel.state.bio,
                            onNameChange: { name in
                                viewModel.onIntent(.changeName(name)) },
                            onEmailChange: { email in
                                viewModel.onIntent(.changeEmail(email)) },
                            onPasswordChange: { password in
                                viewModel.onIntent(.changePassword(password)) },
                            onBioChange: { bio in
                                viewModel.onIntent(.changeBio(bio)) }
            )
            Spacer()
            Button(L10n.save_label) {
                viewModel.onIntent(.updateUser)
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: false))
            .disabled(false)
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.profile_edit_view_title)
    }
}
