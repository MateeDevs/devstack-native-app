//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DatabaseProvider
import KeychainProvider
import NetworkProvider
import SharedDomain
import DevstackKmpShared

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
            try keychain.update(.authToken, value: authToken.token)
            try keychain.update(.userId, value: authToken.userId)
        } catch let NetworkProviderError.requestFailed(statusCode, _) where statusCode == .unathorized {
            let errorResult = AuthError.InvalidLoginCredentials(throwable: nil)
            throw KmmLocalizedError(
                errorResult: errorResult,
                localizedMessage: errorResult.localizedMessage(nil)
            )
        } catch {
            let errorResult = AuthError.LoginFailed(throwable: nil)
            throw KmmLocalizedError(
                errorResult: errorResult,
                localizedMessage: errorResult.localizedMessage(nil)
            )
        }
    }
    
    public func registration(_ data: RegistrationData) async throws {
        do {
            let data = try data.networkModel.encode()
            try await network.request(AuthAPI.registration(data))
        } catch let NetworkProviderError.requestFailed(statusCode, _) where statusCode == .conflict {
            let errorResult = AuthError.EmailAlreadyExist(throwable: nil)
            throw KmmLocalizedError(
                errorResult: errorResult,
                localizedMessage: errorResult.localizedMessage(nil)
            )
        } catch {
            let errorResult = AuthError.RegistrationFailed(throwable: nil)
            throw KmmLocalizedError(
                errorResult: errorResult,
                localizedMessage: errorResult.localizedMessage(nil)
            )
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
