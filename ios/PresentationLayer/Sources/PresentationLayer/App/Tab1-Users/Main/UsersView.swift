//
//  Created by Patrik Cesnek on 03.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import SwiftUI

struct UsersView: View {
    @ObservedObject private var viewModel: UsersViewModel
        
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                RefreshControl(coordinateSpace: .named("RefreshControl")) {
                    viewModel.intent(.onRefresh)
                }
                    .frame(height: 10)
                LazyVStack {
                    ForEach(0..<viewModel.state.allUsers.count, id: \.self) { index in
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(viewModel.state.allUsers[index].fullName)
                                    .padding(.horizontal, 10)
                                Divider()
                            }
                        }
                        .onTapGesture {
                            viewModel.intent(.onUserSelected(viewModel.state.allUsers[index].id))
                        }
                    }
                }
                .onAppear {
                    viewModel.intent(.onAppear)
                    viewModel.intent(.onRefresh)
                }
            }
        }
        .coordinateSpace(name: "RefreshControl")
    }
}

#if DEBUG
import Resolver

struct Users_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCasesForPreviews()
            let vm = UsersViewModel(flowController: nil)
            return PreviewGroup {
                UsersView(viewModel: vm)
                 
            }
    }
}
#endif
