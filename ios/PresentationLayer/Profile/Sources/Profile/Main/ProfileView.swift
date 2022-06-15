//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct ProfileView: View {
    
    @ObservedObject private var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            UserView(viewModel.state.profile?.fullName ?? "")
            Text(viewModel.state.currentLocation)
                .font(.system(size: 20))
                .padding(.top, 16)
            if viewModel.state.remoteConfigLabelIsVisible {
                Text(L10n.profile_view_remote_config_label)
                    .font(.system(size: 17))
                    .padding(.top, 16)
            }
            Button(L10n.profile_view_push_notifications_register_button) {
                viewModel.onIntent(.registerForPushNotifications)
            }
            .buttonStyle(SecondaryButtonStyle())
            Spacer()
            //TODO: secondaryButtonLoading and onSecondaryButtonTap
            SecondaryAndPrimaryButtons(secondaryButtonTitle: L10n.profile_edit_view_title, secondaryButtonLoading: false, onSecondaryButtonTap: { viewModel.onIntent(.updateUser) }, primaryButtonTitle: L10n.profile_view_logout_button, onPrimaryButtonTap: { viewModel.onIntent(.logout) }
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCaseMocks()
        
        let vm = ProfileViewModel(flowController: nil)
        return PreviewGroup {
            ProfileView(viewModel: vm)
        }
    }
}
#endif
