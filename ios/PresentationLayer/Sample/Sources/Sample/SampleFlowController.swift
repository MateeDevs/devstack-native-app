//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

enum SampleFlow: Flow, Equatable {
    case sample
}

public final class SampleFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        let vm = SampleViewModel(flowController: self)
        return BaseHostingController(rootView: SampleView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let sampleFlow = flow as? SampleFlow else { return }
        switch sampleFlow {
        case .sample: do {}
        }
    }
}
