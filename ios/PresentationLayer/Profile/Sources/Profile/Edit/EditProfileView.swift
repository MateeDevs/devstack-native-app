//
//  Created by Petr Chmelar on 22.05.2022
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
            UserEditProfileFields(
                title: L10n.profile_edit_view_title,
                firstName: viewModel.state.user?.firstName ?? "",
                lastName: viewModel.state.user?.lastName ?? "",
                phone: viewModel.state.user?.phone ?? "",
                bio: viewModel.state.user?.bio ?? "",
                onFirstNameChange: { firstName in viewModel.onIntent(.changeFisrtName(firstName)) },
                onLastNameChange: { lastName in viewModel.onIntent(.changeLastName(lastName)) },
                onPhoneChange: { phone in viewModel.onIntent(.changePhone(phone)) },
                onBioChange: { bio in viewModel.onIntent(.changeBio(bio)) }
            )
            Spacer()
            UserEditProfileSaveButton(
                buttonTitle: L10n.profile_edit_view_save_button,
                buttonLoading: viewModel.state.saveButtonLoading,
                onButtonTap: { viewModel.onIntent(.save) }
            )
        }
        .padding()
        .lifecycle(viewModel)
        .navigationTitle(L10n.profile_view_toolbar_title)
    }
}

#if DEBUG
import Resolver
import SharedDomainMocks

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
