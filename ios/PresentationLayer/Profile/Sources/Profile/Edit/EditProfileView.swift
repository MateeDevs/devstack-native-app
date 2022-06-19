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
            EditationFields(firstName: viewModel.state.profile?.firstName ?? "",
                            lastName: viewModel.state.profile?.lastName ?? "",
                            email: viewModel.state.profile?.email ?? "",
                            phone: viewModel.state.profile?.phone ?? "",
                            bio: viewModel.state.profile?.bio ?? "",
                            onFirstNameChange: { firstName in
                                viewModel.onIntent(.changeFirstName(firstName)) },
                            onLastNameChange: { lastName in
                                viewModel.onIntent(.changeLastName(lastName)) },
                            onEmailChange: { email in
                                viewModel.onIntent(.changeEmail(email)) },
                            onPhoneChange: { phone in
                                viewModel.onIntent(.changePhone(phone)) },
                            onBioChange: { bio in
                                viewModel.onIntent(.changeBio(bio)) }
            )
            Spacer()
            Button(L10n.save_label) {
                viewModel.onIntent(.updateUser)
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: viewModel.state.saveButtonLoading))
            .disabled(viewModel.state.saveButtonLoading)
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.profile_edit_view_title)
        .padding()
    }
}

#if DEBUG
import Resolver
import SharedDomainMocks
import Utilities

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCaseMocks()
        
        let vm = EditProfileViewModel(flowController: nil)
        return PreviewGroup {
            EditProfileView(viewModel: vm)
        }
    }
}
#endif
