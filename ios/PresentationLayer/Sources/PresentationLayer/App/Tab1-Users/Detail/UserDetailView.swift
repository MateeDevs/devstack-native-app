//
//  Created by Patrik Cesnek on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    @ObservedObject private var viewModel: UserDetailViewModel
        
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                RefreshControl(coordinateSpace: .named("RefreshControl")) {
                    viewModel.intent(.onRefresh)
                }
                    .frame(height: 10)
                VStack {
                ZStack {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.yellow)
                    Text(viewModel.state.user?.fullName.initials ?? "")
                        .font(.title)
                }
                .padding()
                Spacer(minLength: 40)
                VStack {
                    Text(viewModel.state.user?.fullName ?? "")
                        .font(.title)
                    Spacer()
                    Text(viewModel.state.user?.bio ?? "")
                }
                }
            }
            .onAppear {
                viewModel.intent(.onAppear)
                viewModel.intent(.onRefresh)
            }
        }
        .coordinateSpace(name: "RefreshControl")
    }
}

#if DEBUG
import Resolver

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCasesForPreviews()
        let vm = UserDetailViewModel(flowController: nil, userId: "")
            return PreviewGroup {
                UserDetailView(viewModel: vm)
            }
    }
}
#endif
