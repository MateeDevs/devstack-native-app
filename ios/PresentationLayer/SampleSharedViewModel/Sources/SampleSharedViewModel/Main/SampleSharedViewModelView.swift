//
//  Created by Julia Jakubcova on 02/08/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import KMPShared
import SwiftUI
import UIToolkit

struct SampleSharedViewModelView: View {
    
    private var viewModel: KMPShared.SampleSharedViewModel
    @State private var state: SampleSharedState = .init(loading: false, sampleText: nil, error: nil)
    
    private weak var flowController: FlowController?
    
    init(flowController: FlowController?) {
        self.flowController = flowController
        self.viewModel = Container.shared.sampleSharedViewModel.resolve()
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            if state.loading {
                PrimaryProgressView()
            } else {
                VStack(spacing: AppTheme.Dimens.spaceMedium) {
                    Text("This is a sample with SwiftUI and shared VM")
                    Text(state.sampleText?.value ?? "")
                    Button(
                        action: { viewModel.onIntent(intent: SampleSharedIntentOnButtonTapped()) },
                        label: {
                            Text("Click me!")
                        }
                    )
                }
            }
        }
        .navigationTitle(L10n.users_view_toolbar_title)
        .onAppear {
            viewModel.onIntent(intent: SampleSharedIntentOnAppeared())
        }
        .bindViewModel(
            viewModel,
            stateBinding: $state,
            onEvent: { event in
                switch event {
                case is SampleSharedEventShowMessage: print((event as! SampleSharedEventShowMessage).message)
                default: print("Event \(event) not recognized")
                }
            }
        )
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory

#Preview {
    Container.shared.registerViewModelMocks()
    
    return SampleSharedViewModelView(flowController: nil)
}
#endif

