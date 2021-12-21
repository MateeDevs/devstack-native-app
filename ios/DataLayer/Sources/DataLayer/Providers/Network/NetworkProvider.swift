//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Moya
import RxSwift

public protocol NetworkProviderDelegate: AnyObject {
    func didReceiveHttpUnauthorized()
}

public protocol HasNetworkProvider {
    var networkProvider: NetworkProvider { get }
}

public protocol NetworkProvider {
    
    var delegate: NetworkProviderDelegate? { get set }

    ///
    /// Function for observing on a specified network call.
    /// Automatically filters out API errors.
    ///
    /// - parameter endpoint: TargetType from Moya which specify API endpoint to be called.
    /// - parameter withInterceptor: Optional parameter to specify whether build-in interceptor should be enabled.
    /// - returns: Observable which emits Response of a network call.
    ///
    func observableRequest(_ endpoint: TargetType, withInterceptor: Bool) -> Observable<Response>
}

// This extension exists only to provide default values for parameters
extension NetworkProvider {
    func observableRequest(_ endpoint: TargetType, withInterceptor: Bool = true) -> Observable<Response> {
        observableRequest(endpoint, withInterceptor: withInterceptor)
    }
}
