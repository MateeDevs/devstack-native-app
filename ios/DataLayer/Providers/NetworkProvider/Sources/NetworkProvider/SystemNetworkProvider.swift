//
//  Created by Petr Chmelar on 02.04.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import OSLog
import UIKit

public struct SystemNetworkProvider {
    
    private let readAuthToken: () throws -> String
    private weak var _delegate: NetworkProviderDelegate?

    public init(
        readAuthToken: @escaping () throws -> String,
        delegate: NetworkProviderDelegate?
    ) {
        self.readAuthToken = readAuthToken
        self._delegate = delegate
    }
    
    private let serviceHeaders = [
        "Client-Type": "ios",
        "Client-App": Bundle.main.bundleIdentifier ?? "undefined",
        "Client-AppVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "undefined",
        "Client-OS": UIDevice.current.systemVersion,
        "Client-HW": UIDevice.current.identifierForVendor?.uuidString ?? "undefined"
    ]
}

extension SystemNetworkProvider: NetworkProvider {
    
    public var delegate: NetworkProviderDelegate? {
        get {
            _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    public func request(_ endpoint: NetworkEndpoint, withInterceptor: Bool) async throws -> Data {
        
        // Create request
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
        request.httpMethod = endpoint.method.rawValue
        
        // Add headers
        serviceHeaders.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        if let headers = endpoint.headers {
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        // Add auth token if available
        do {
            let authToken = try readAuthToken()
            request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        } catch {}
        
        // Prepare request based on task
        switch endpoint.task {
        case .requestPlain:
            break
        case let .requestParameters(parameters, encoding):
            request = try encoding.encode(request, with: parameters)
        }
        
        // Fire request
        #if DEBUG
        Logger.log(request: request)
        #endif
        let (data, response) = try await URLSession.shared.data(for: request)
        #if DEBUG
        Logger.log(response: response, data: data)
        #endif
        
        // Catch HTTP errors
        if let httpResponse = response as? HTTPURLResponse {
            if withInterceptor, httpResponse.statusCode == NetworkStatusCode.unathorized.rawValue {
                delegate?.didReceiveHttpUnauthorized()
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                throw NetworkProviderError.requestFailed(
                    statusCode: NetworkStatusCode(rawValue: httpResponse.statusCode) ?? .unknown,
                    message: String(data: data, encoding: .utf8) ?? ""
                )
            }
        }
        
        return data
    }
}
