//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct SampleView: View {
    
    @ObservedObject private var viewModel: SampleViewModel
    
    init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            if viewModel.state.isLoading {
                PrimaryProgressView()
            } else {
                VStack(spacing: AppTheme.Dimens.spaceMedium) {
                    Text("This is a sample with SwiftUI and iOS VM")
                    Text(viewModel.state.sampleText?.value ?? "")
                    Button(
                        action: { viewModel.onIntent(.onButtonTapped) },
                        label: {
                            Text("Click me!")
                        }
                    )
                }
            }
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.bottom_bar_item_1)
        .toastView(Binding<ToastData?>(
            get: { viewModel.state.toast },
            set: { toast in viewModel.onIntent(.onToastFinished) }
        ))
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = SampleViewModel(flowController: nil)
    return SampleView(viewModel: vm)
}
#endif
