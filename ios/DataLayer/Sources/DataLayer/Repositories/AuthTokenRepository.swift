//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Resolver
import RxSwift

public struct AuthTokenRepositoryImpl: AuthTokenRepository {
    
    @Injected private var database: DatabaseProvider
    @Injected private var keychain: KeychainProvider
    @Injected private var network: NetworkProvider
    
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
