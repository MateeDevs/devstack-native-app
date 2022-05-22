//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer

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
        do {
            let data = try data.networkModel.encode()
            let authToken = try await network.request(AuthAPI.login(data), withInterceptor: false).map(NETAuthToken.self).domainModel
            keychain.update(.authToken, value: authToken.token)
            keychain.update(.userId, value: authToken.userId)
            return authToken
        } catch { throw AuthError.Login(error) }
    }
    
    public func read() throws -> AuthToken {
        guard let userId = keychain.read(.userId), let token = keychain.read(.authToken) else { throw AuthError.notLogged }
        return AuthToken(userId: userId, token: token)
    }
    
    public func delete() throws {
        keychain.deleteAll()
        try database.deleteAll()
    }
}
