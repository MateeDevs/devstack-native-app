//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import NetworkProvider

public final class NetworkProviderMock {
    
    public var requestCallsCount = 0
    public var requestReturnData: Data?
    public var requestReturnError: Error?

    private weak var _delegate: NetworkProviderDelegate?

    public init() {}
}

extension NetworkProviderMock: NetworkProvider {
    
    public var delegate: NetworkProviderDelegate? {
        get {
            _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    public func request(_ endpoint: NetworkEndpoint, withInterceptor: Bool) async throws -> Data {
        requestCallsCount += 1
        if let error = requestReturnError {
            throw error
        } else if let data = requestReturnData {
            return data
        } else {
            throw NetworkProviderError.requestFailed(statusCode: .notFound, message: "")
        }
    }
}
