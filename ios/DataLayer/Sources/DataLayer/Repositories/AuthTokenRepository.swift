//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import RxSwift

public struct AuthTokenRepositoryImpl: AuthTokenRepository {

    public typealias Dependencies =
        HasDatabaseProvider &
        HasKeychainProvider &
        HasNetworkProvider

    private let database: DatabaseProvider
    private let keychain: KeychainProvider
    private let network: NetworkProvider
    
    public init(dependencies: Dependencies) {
        self.database = dependencies.databaseProvider
        self.keychain = dependencies.keychainProvider
        self.network = dependencies.networkProvider
    }
    
    public func create(_ data: LoginData) -> Observable<AuthToken> {
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
