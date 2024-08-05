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
    
    @State private var toastData: ToastData?
    
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
        .navigationTitle(L10n.bottom_bar_item_2)
        .onAppear {
            viewModel.onIntent(intent: SampleSharedIntentOnAppeared())
        }
        .bindViewModel(
            viewModel,
            stateBinding: $state,
            onEvent: { event in
                switch event {
                case is SampleSharedEventShowMessage: do {
                    toastData = ToastData((event as! SampleSharedEventShowMessage).message, hideAfter: 2)
                }
                default: print("Event \(event) not recognized")
                }
            }
        )
        .toastView($toastData)
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

