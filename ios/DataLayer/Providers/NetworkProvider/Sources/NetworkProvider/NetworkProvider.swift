//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

public protocol NetworkProviderDelegate: AnyObject {
    func didReceiveHttpUnauthorized()
}

public protocol NetworkProvider {
    
    var delegate: NetworkProviderDelegate? { get set }
    
    ///
    /// Function for triggering a specified network call.
    /// Automatically throws API errors.
    ///
    /// - parameter endpoint: NetworkTarget which specify API endpoint to be called.
    /// - parameter withInterceptor: Optional parameter to specify whether build-in interceptor should be enabled.
    /// - returns: Data from a network call.
    ///
    @discardableResult
    func request(_ endpoint: NetworkEndpoint, withInterceptor: Bool) async throws -> Data
}

// This extension exists only to provide default values for parameters
public extension NetworkProvider {
    @discardableResult
    func request(_ endpoint: NetworkEndpoint, withInterceptor: Bool = true) async throws -> Data {
        try await request(endpoint, withInterceptor: withInterceptor)
    }
}
