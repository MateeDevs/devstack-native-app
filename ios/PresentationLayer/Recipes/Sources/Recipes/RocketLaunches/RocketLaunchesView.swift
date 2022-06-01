//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct RocketLaunchesView: View {
    
    @ObservedObject private var viewModel: RocketLaunchesViewModel
    
    init(viewModel: RocketLaunchesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            if viewModel.state.rocketLaunches.isEmpty && viewModel.state.isLoading {
                PrimaryProgressView()
            } else {
                List {
                    ForEach(viewModel.state.rocketLaunches, id: \.self) { rocketLaunch in
                        HStack {
                            Text(rocketLaunch.site)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.rocket_launches_view_toolbar_title)
    }
}

#if DEBUG
import Resolver
import SharedDomainMocks

struct RocketLaunchesView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCaseMocks()
        
        let vm = RocketLaunchesViewModel(flowController: nil)
        return PreviewGroup {
            RocketLaunchesView(viewModel: vm)
        }
    }
}
#endif
