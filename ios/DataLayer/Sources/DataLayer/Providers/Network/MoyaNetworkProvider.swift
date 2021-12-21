//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import Moya
import RxMoya
import RxSwift
import UIKit

public struct MoyaNetworkProvider {
    
    private let keychain: KeychainProvider
    private let database: DatabaseProvider
    
    private weak var _delegate: NetworkProviderDelegate?

    /// Custom Moya provider
    /// Idea taken from [Moya - ComposingProvider](https://github.com/Moya/Moya/blob/master/docs/Examples/ComposingProvider.md)
    private let moyaProvider: MoyaProvider<MultiTarget>

    public init(keychainProvider: KeychainProvider, databaseProvider: DatabaseProvider) {
        self.keychain = keychainProvider
        self.database = databaseProvider
        
        let endpointClosure = { (target: MultiTarget) -> Endpoint in
            var defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            
            // Add service headers
            defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: [
                "Client-Type": "ios",
                "Client-App": Bundle.main.bundleIdentifier ?? "undefined",
                "Client-AppVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "undefined",
                "Client-API": "\(NetworkingConstants.apiVersion)",
                "Client-OS": UIDevice.current.systemVersion,
                "Client-HW": UIDevice.current.identifierForVendor?.uuidString ?? "undefined"
            ])
            
            // Add auth header
            if let authToken = keychainProvider.get(.authToken) {
                defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: ["Authorization": "Bearer \(authToken)"])
            }
            
            return defaultEndpoint
        }
        
        let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
            do {
                let request = try endpoint.urlRequest()
                done(.success(request))
            } catch let error as NSError {
                Logger.error("Moya request closure error:\n%@", "\(error)", category: .networking)
                return
            }
        }
        
        // Configure plugins
        var plugins: [PluginType] = []
        plugins.append(CustomNetworkActivityPlugin())
        #if DEBUG
        let loggerConfig = NetworkLoggerPlugin.Configuration(
            formatter: NetworkLoggerPlugin.Configuration.Formatter(responseData: { (_ data: Data) -> String in
                do {
                    let dataAsJSON = try JSONSerialization.jsonObject(with: data)
                    let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
                    return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
                } catch {
                    return String(data: data, encoding: .utf8) ?? ""
                }
            }),
            logOptions: [.verbose, .formatRequestAscURL]
        )
        plugins.append(NetworkLoggerPlugin(configuration: loggerConfig))
        #endif
        
        moyaProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure, requestClosure: requestClosure, plugins: plugins)
    }
}

extension MoyaNetworkProvider: NetworkProvider {
    
    public var delegate: NetworkProviderDelegate? {
        get {
            _delegate
        }
        set {
            _delegate = newValue
        }
    }

    public func observableRequest(_ endpoint: TargetType, withInterceptor: Bool) -> Observable<Response> {
        moyaProvider.rx.request(MultiTarget(endpoint))
            .flatMap { response -> PrimitiveSequence<SingleTrait, Response> in
                if withInterceptor, response.statusCode == StatusCode.httpUnathorized.rawValue {
                    delegate?.didReceiveHttpUnauthorized()
                    return Single.error(MoyaError.statusCode(response))
                } else {
                    return Single.just(response)
                }
            }
            .asObservable()
            .filterSuccessfulStatusCodes()
            .catch { error -> Observable<Response> in
                guard let moyaError = error as? MoyaError,
                      let response = moyaError.response,
                      let statusCode = StatusCode(rawValue: response.statusCode) else { return .error(error) }
                return .error(RepositoryError(statusCode: statusCode, message: response.description))
            }
    }
}
