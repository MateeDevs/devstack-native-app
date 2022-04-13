//
//  Created by Petr Chmelar on 03.04.2022
//  Copyright © 2022 Matee. All rights reserved.
//

// Taken from Alamofire

import Foundation

/// Uses `JSONSerialization` to create a JSON representation of the parameters object, which is set as the body of the request.
/// The `Content-Type` HTTP header field of an encoded request is set to `application/json`.
public struct JSONEncoding: ParameterEncoding {
    
    // MARK: Properties

    /// Returns a `JSONEncoding` instance with default writing options.
    public static var `default`: JSONEncoding { JSONEncoding() }

    // MARK: Initialization

    public init() {}

    // MARK: Encoding

    public func encode(_ urlRequest: URLRequest, with parameters: [String: Any]) throws -> URLRequest {
        var urlRequest = urlRequest

        let data = try JSONSerialization.data(withJSONObject: parameters)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data

        return urlRequest
    }
}
