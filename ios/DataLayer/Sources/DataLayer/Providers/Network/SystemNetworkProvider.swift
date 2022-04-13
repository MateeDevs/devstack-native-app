//
//  Created by Petr Chmelar on 02.04.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import OSLog
import RxSwift
import UIKit

public struct SystemNetworkProvider {
    
    private let keychainProvider: KeychainProvider
    private weak var _delegate: NetworkProviderDelegate?

    public init(
        keychainProvider: KeychainProvider,
        delegate: NetworkProviderDelegate?
    ) {
        self.keychainProvider = keychainProvider
        self._delegate = delegate
    }
    
    private let serviceHeaders = [
        "Client-Type": "ios",
        "Client-App": Bundle.main.bundleIdentifier ?? "undefined",
        "Client-AppVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "undefined",
        "Client-API": "\(NetworkingConstants.apiVersion)",
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
        if let authToken = keychainProvider.get(.authToken) {
            request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
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
            if withInterceptor, httpResponse.statusCode == StatusCode.httpUnathorized.rawValue {
                delegate?.didReceiveHttpUnauthorized()
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                throw RepositoryError(
                    statusCode: StatusCode(rawValue: httpResponse.statusCode) ?? .networkError,
                    message: String(data: data, encoding: .utf8) ?? ""
                )
            }
        }
        
        return data
    }
    
    public func observableRequest(_ endpoint: NetworkEndpoint, withInterceptor: Bool) -> Observable<Data> {
        return Observable<Data>.create { observer in
            Task {
                do {
                    let data = try await self.request(endpoint, withInterceptor: withInterceptor)
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
