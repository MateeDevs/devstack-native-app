//
//  Created by Petr Chmelar on 05.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DataLayer
import DomainLayer
import Resolver

public extension Resolver {
    static func registerDependencies() {
        // UseCases
        register { GetProfileIdUseCaseImpl(authTokenRepository: resolve()) as GetProfileIdUseCase }
        
        // Repositories
        register {
            AuthTokenRepositoryImpl(
                databaseProvider: resolve(),
                keychainProvider: resolve(),
                networkProvider: resolve()
            ) as AuthTokenRepository
        }
        
        // Providers
        register { RealmDatabaseProvider() as DatabaseProvider }
        register { SystemKeychainProvider(userDefaultsProvider: resolve()) as KeychainProvider }
        register { SystemNetworkProvider(keychainProvider: resolve(), delegate: nil) as NetworkProvider }
        register { SystemUserDefaultsProvider() as UserDefaultsProvider }
    }
}
