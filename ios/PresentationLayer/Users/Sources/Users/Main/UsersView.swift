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
            if viewModel.state.isLoading {
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

// #if DEBUG
// import Resolver
//
// struct UsersView_Previews: PreviewProvider {
//    static var previews: some View {
//        Resolver.registerUseCasesForPreviews()
//
//        let vm = UsersViewModel(flowController: nil)
//        return PreviewGroup {
//            UsersView(viewModel: vm)
//        }
//    }
// }
// #endif
