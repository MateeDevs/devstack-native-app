//
//  Created by David Kadlček on 15.11.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import KMPShared

open class UseCaseResultMock: UseCaseResult {
    
    public var executeThrowableError: Swift.Error?
    public var executeCallsCount = 0
    public var executeCalled: Bool {
        return executeCallsCount > 0
    }
    public var executeReturnValue: Result<AnyObject>! // swiftlint:disable:this implicitly_unwrapped_optional
    
    public var receivedParams: Any?
    
    public var executeClosure: (() throws -> Result<AnyObject>)?
    
    public init() {}
    
    public init(executeReturnValue: Result<AnyObject>) {
        self.executeReturnValue = executeReturnValue 
    }
    
    // MARK: - execute
    public func invoke(params: Any?) async throws -> Result<AnyObject> {
        executeCallsCount += 1
        receivedParams = params
        
        if let error = executeThrowableError {
            throw error
        }
        
        guard let executeClosure else {
            return executeReturnValue
        }
        
        return try executeClosure()
    }
}
