//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import RxSwift

public struct AuthTokenRepositoryImpl: AuthTokenRepository {
    
    private let database: DatabaseProvider
    private let keychain: KeychainProvider
    private let network: NetworkProvider
    
    public init(
        databaseProvider: DatabaseProvider,
        keychainProvider: KeychainProvider,
        networkProvider: NetworkProvider
    ) {
        database = databaseProvider
        keychain = keychainProvider
        network = networkProvider
    }
    
    public func create(_ data: LoginData) async throws -> AuthToken {
        guard let data = data.networkModel.encoded else { throw CommonError.encoding }
        let authToken = try await network.request(AuthAPI.login(data), withInterceptor: false).map(NETAuthToken.self).domainModel
        keychain.save(.authToken, value: authToken.token)
        keychain.save(.userId, value: authToken.userId)
        return authToken
    }
    
    public func createRx(_ data: LoginData) -> Observable<AuthToken> {
        guard let data = data.networkModel.encoded else { return .error(CommonError.encoding) }
        let endpoint = AuthAPI.login(data)
        return network.observableRequest(endpoint, withInterceptor: false).map(NETAuthToken.self).mapToDomain().do { authToken in
            self.keychain.save(.authToken, value: authToken.token)
            self.keychain.save(.userId, value: authToken.userId)
        }
    }
    
    public func read() -> AuthToken? {
        guard let userId = keychain.get(.userId), let token = keychain.get(.authToken) else { return nil }
        return AuthToken(userId: userId, token: token)
    }
    
    public func delete() {
        keychain.deleteAll()
        database.deleteAll()
    }
}
