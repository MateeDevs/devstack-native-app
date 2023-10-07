//
//  Created by Petr Chmelar on 21.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct UserDetailView: View {
    
    @ObservedObject private var viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            UserView(viewModel.state.user?.fullName ?? "")
            Spacer()
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.user_detail_view_toolbar_title)
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Container.shared.registerUseCaseMocks()
        
        let vm = UserDetailViewModel(userId: "userId", flowController: nil)
        return PreviewGroup {
            UserDetailView(viewModel: vm)
        }
    }
}
#endif
