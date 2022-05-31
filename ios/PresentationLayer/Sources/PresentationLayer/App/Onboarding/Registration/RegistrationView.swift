//
//  Created by Petr Chmelar on 13.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct RegistrationView: View {
    
    @ObservedObject private var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            EmailAndPasswordFields(
                email: viewModel.state.email,
                password: viewModel.state.password,
                onEmailChange: { email in viewModel.onIntent(.changeEmail(email)) },
                onPasswordChange: { password in viewModel.onIntent(.changePassword(password)) }
            )
            Spacer()
            PrimaryAndSecondaryButtons(
                primaryButtonTitle: L10n.login_view_register_button_title,
                primaryButtonLoading: viewModel.state.registerButtonLoading,
                onPrimaryButtonTap: { viewModel.onIntent(.register) },
                secondaryButtonTitle: L10n.login_view_login_button_title,
                onSecondaryButtonTap: { viewModel.onIntent(.login) }
            )
        }
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.onIntent(.dismissAlert) }
        )) { alert in .init(alert) }
        .lifecycle(viewModel)
    }
}

#if DEBUG
import Resolver

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCasesForPreviews()
        
        let vm = RegistrationViewModel(flowController: nil)
        return PreviewGroup {
            RegistrationView(viewModel: vm)
        }
    }
}
#endif
