//
//  Created by David Sobíšek on 23.10.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import UIKit
import UIToolkit

enum FreerunFlow: Flow {
    case freerun(Freerun)
    
    enum Freerun: Equatable {
        
    }
}

public final class FreerunFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        let view = FreerunView()
        return BaseHostingController(rootView: view)
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let freerunFlow = flow as? FreerunFlow else { return }
        switch freerunFlow {
        
        }
    }
}

// MARK: Freerun flow
extension FreerunFlowController {
    func handleFreerunFlow(_ flow: FreerunFlow.Freerun) {
        switch flow {
        
        }
    }
}
