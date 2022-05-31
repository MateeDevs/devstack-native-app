//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer

public struct AuthRepositoryImpl: AuthRepository {
    
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
    
    public func login(_ data: LoginData) async throws {
        do {
            let data = try data.networkModel.encode()
            let authToken = try await network.request(AuthAPI.login(data), withInterceptor: false).map(NETAuthToken.self).domainModel
            keychain.update(.authToken, value: authToken.token)
            keychain.update(.userId, value: authToken.userId)
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
        guard let profileId = keychain.read(.userId) else { throw AuthError.notLogged }
        return profileId
    }
    
    public func logout() throws {
        keychain.deleteAll()
        try database.deleteAll()
    }
}
