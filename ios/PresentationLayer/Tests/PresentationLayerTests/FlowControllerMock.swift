//
//  Created by Petr Chmelar on 07.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
@testable import PresentationLayer

class FlowControllerMock: FlowController {
    
    public var handleFlowCount = 0
    public var handleFlowValue: Flow?
    
    override func handleFlow(_ flow: Flow) {
        handleFlowCount += 1
        handleFlowValue = flow
    }
}
