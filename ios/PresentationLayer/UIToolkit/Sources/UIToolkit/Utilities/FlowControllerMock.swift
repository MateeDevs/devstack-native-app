//
//  Created by Petr Chmelar on 30.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public class FlowControllerMock<T: Flow & Equatable>: FlowController {
    
    public var handleFlowCount = 0
    public var handleFlowValue: T?
    
    override public func handleFlow(_ flow: Flow) {
        handleFlowCount += 1
        handleFlowValue = flow as? T
    }
}
