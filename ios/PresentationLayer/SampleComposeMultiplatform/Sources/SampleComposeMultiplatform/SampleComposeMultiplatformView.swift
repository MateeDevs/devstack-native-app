//
//  Created by Julia Jakubcova on 02/08/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import DependencyInjection
import Factory
import KMPShared
import SwiftUI
import UIToolkit

struct SampleComposeMultiplatformViewController: UIViewControllerRepresentable {
    
    private var viewModel: KMPShared.SampleSharedViewModel
    private let onEvent: (SampleSharedEvent) -> Void
    
    init(viewModel: KMPShared.SampleSharedViewModel, onEvent: @escaping (SampleSharedEvent) -> Void) {
        self.viewModel = viewModel
        self.onEvent = onEvent
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return SampleComposeMultiplatformScreenViewControllerKt.SampleComposeMultiplatformScreenViewController(
            viewModel: viewModel,
            onEvent: onEvent
        )
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct SampleComposeMultiplatformView : View {
    
    @Injected(\.sampleSharedViewModel) private(set) var viewModel: KMPShared.SampleSharedViewModel
    private weak var flowController: FlowController?
    
    @State private var toastData: ToastData?
    
    init(flowController: FlowController?) {
        self.flowController = flowController
    }
    
    var body: some View {
        SampleComposeMultiplatformViewController(
            viewModel: viewModel,
            onEvent: { event in
                switch event {
                case is SampleSharedEventShowMessage: toastData = ToastData((event as! SampleSharedEventShowMessage).message, hideAfter: 2)
                default: print("Event \(event) not recognized")
                }
            }
        )
        .toastView($toastData)
        .navigationTitle(L10n.bottom_bar_item_3)
    }
}
