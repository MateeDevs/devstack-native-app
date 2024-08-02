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
    private weak var flowController: FlowController?
    
    init(flowController: FlowController?) {
        self.flowController = flowController
        self.viewModel = Container.shared.sampleSharedViewModel.resolve()
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return SampleComposeMultiplatformScreenViewControllerKt.SampleComposeMultiplatformScreenViewController(
            viewModel: viewModel,
            onEvent: { event in
                switch event {
                case is SampleSharedEventShowMessage: print((event as! SampleSharedEventShowMessage).message)
                default: print("Event \(event) not recognized")
                }
            }
        )
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
