//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DatabaseProvider
import KeychainProvider
import NetworkProvider
import SharedDomain
import UserDefaultsProvider

public struct AuthRepositoryImpl: AuthRepository {
    
    private let database: DatabaseProvider
    private let keychain: KeychainProvider
    private let network: NetworkProvider
    private let userDefaults: UserDefaultsProvider
    
    public init(
        databaseProvider: DatabaseProvider,
        keychainProvider: KeychainProvider,
        networkProvider: NetworkProvider,
        userDefaultsProvider: UserDefaultsProvider
    ) {
        database = databaseProvider
        keychain = keychainProvider
        network = networkProvider
        userDefaults = userDefaultsProvider
    }
    
    public func login(_ data: LoginData) async throws {
        do {
            let data = try data.networkModel.encode()
            let authToken = try await network.request(AuthAPI.login(data), withInterceptor: false).map(NETAuthToken.self).domainModel
            try keychain.update(.authToken, value: authToken.token)
            try keychain.update(.userId, value: authToken.userId)
            try userDefaults.update(.userId, value: authToken.userId)
        } catch let NetworkProviderError.requestFailed(statusCode, _) where statusCode == .unathorized {
            throw AuthError.login(.invalidCredentials)
        } catch {
            throw AuthError.login(.failed)
        }
    }
    
    public func registration(_ data: RegistrationData) async throws {
        do {
            let data = try data.networkModel.encode()
            try await network.request(AuthAPI.registration(data))
        } catch let NetworkProviderError.requestFailed(statusCode, _) where statusCode == .conflict {
            throw AuthError.registration(.userAlreadyExists)
        } catch {
            throw AuthError.registration(.failed)
        }
    }
    
    public func readProfileId() throws -> String {
        try keychain.read(.userId)
    }
    
    public func logout() throws {
        try keychain.deleteAll()
        try database.deleteAll()
    }
}
