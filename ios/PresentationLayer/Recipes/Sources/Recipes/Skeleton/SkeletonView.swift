//
//  Created by Petr Chmelar on 07.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct SkeletonView: View {
    
    @ObservedObject private var viewModel: SkeletonViewModel
    
    init(viewModel: SkeletonViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            HeadlineText(viewModel.state.title ?? .placeholder(length: 10))
                .skeleton(viewModel.state.title == nil)
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.skeleton_view_toolbar_title)
    }
}

#if DEBUG
import Resolver
import SharedDomainMocks

struct SkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCaseMocks()
        
        let vm = SkeletonViewModel(flowController: nil)
        return PreviewGroup {
            SkeletonView(viewModel: vm)
        }
    }
}
#endif
