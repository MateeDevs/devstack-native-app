//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject private var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(AppTheme.Colors.primaryColor))
                Text(viewModel.state.profile?.fullName.initials ?? "")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.top, 64)
            Text(viewModel.state.profile?.fullName ?? "")
                .font(.system(size: 20))
                .padding(.top, 16)
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
            Button(L10n.profile_view_logout_button) {
                viewModel.onIntent(.logout)
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .lifecycle(viewModel)
        .navigationTitle(L10n.profile_view_toolbar_title)
    }
}

#if DEBUG
import Resolver

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCasesForPreviews()
        
        let vm = ProfileViewModel(flowController: nil)
        return PreviewGroup {
            ProfileView(viewModel: vm)
        }
    }
}
#endif
