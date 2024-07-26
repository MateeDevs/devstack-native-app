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
                PagingScrollView(
                    isFetchingMore: viewModel.state.isFetchingMore,
                    triggerAction: { viewModel.onIntent(.fetchMore) },
                    content: {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.state.users, id: \.self) { user in
                                Button(
                                    action: { viewModel.onIntent(.openUserDetail(id: user.id)) },
                                    label: {
                                        HStack {
                                            Text(user.fullName)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                        }
                                        .contentShape(Rectangle())
                                        .padding()
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                    }
                                )
                                .shadow(radius: 10, y: 10)
                                .foregroundColor(Color.primary)
                            }
                            
                            if viewModel.state.isFetchingMore {
                                ProgressView()
                            }
                        }
                        .padding(.vertical)
                    }
                )
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
