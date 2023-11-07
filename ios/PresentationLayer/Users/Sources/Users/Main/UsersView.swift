//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct UsersView: View {
    
    @ObservedObject private var viewModel: UsersViewModel
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            if viewModel.state.users.isEmpty && viewModel.state.isLoading {
                PrimaryProgressView()
            } else {
                List {
                    ForEach(viewModel.state.users, id: \.self) { user in
                        HStack {
                            Text(user.fullName)
                            Spacer()
                            NavigationLink.empty
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.onIntent(.openUserDetail(id: user.id))
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.users_view_toolbar_title)
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = UsersViewModel(flowController: nil)
    return UsersView(viewModel: vm)
}
#endif
