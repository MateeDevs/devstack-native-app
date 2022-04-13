//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer
import Foundation
import RxSwift

public class NetworkProviderMock {
    
    public var requestCallsCount = 0
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
        } else {
            return endpoint.sampleData
        }
    }
    
    public func observableRequest(_ endpoint: NetworkEndpoint, withInterceptor: Bool) -> Observable<Data> {
        if let error = requestReturnError {
            return Observable.error(error).do(onError: { _ in self.requestCallsCount += 1 })
        } else {
            return Observable.just(endpoint.sampleData).do(onNext: { _ in self.requestCallsCount += 1 })
        }
    }
}
