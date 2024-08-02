//
//  Created by Julia Jakubcova on 02/08/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Factory
import KMPShared
import SwiftUI
import UIKit
import UIToolkit

enum SampleSharedViewModelFlow: Flow, Equatable {
    case sampleSharedViewModel
}

public final class SampleSharedViewModelFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        return BaseHostingController(rootView: SampleSharedViewModelView(flowController: self))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let sampleSharedViewModelFlow = flow as? SampleSharedViewModelFlow else { return }
        switch sampleSharedViewModelFlow {
        case .sampleSharedViewModel: do {}
        }
    }
}
