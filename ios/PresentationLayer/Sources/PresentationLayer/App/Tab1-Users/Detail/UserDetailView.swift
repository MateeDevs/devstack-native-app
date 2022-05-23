//
//  Created by Petr Chmelar on 21.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    @ObservedObject private var viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(AppTheme.Colors.primaryColor)
                Text(viewModel.state.user?.fullName.initials ?? "")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.top, 64)
            Text(viewModel.state.user?.fullName ?? "")
                .font(.system(size: 20))
                .padding(.top, 16)
            Spacer()
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.user_detail_view_toolbar_title)
    }
}

#if DEBUG
import Resolver

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCasesForPreviews()
        
        let vm = UserDetailViewModel(userId: "userId", flowController: nil)
        return PreviewGroup {
            UserDetailView(viewModel: vm)
        }
    }
}
#endif
