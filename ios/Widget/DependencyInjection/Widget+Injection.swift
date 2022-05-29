//
//  Created by Petr Chmelar on 05.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import AuthToolkit
import DatabaseProvider
import KeychainProvider
import NetworkProvider
import Resolver
import SharedDomain
import UserDefaultsProvider

public extension Resolver {
    static func registerDependencies() {
        // UseCases
        register { IsUserLoggedUseCaseImpl(getProfileIdUseCase: resolve()) as IsUserLoggedUseCase }
        register { GetProfileIdUseCaseImpl(authRepository: resolve()) as GetProfileIdUseCase }
        
        // Repositories
        register {
            AuthRepositoryImpl(
                databaseProvider: resolve(),
                keychainProvider: resolve(),
                networkProvider: resolve()
            ) as AuthRepository
        }
        
        // Providers
        register { RealmDatabaseProvider() as DatabaseProvider }
        register { SystemKeychainProvider() as KeychainProvider }
        
        register { SystemNetworkProvider(
            readAuthToken: {
                let keychainProvider: KeychainProvider = Resolver.resolve()
                return try keychainProvider.read(.authToken)
            },
            delegate: nil
        ) as NetworkProvider
        }
        
        register { SystemUserDefaultsProvider() as UserDefaultsProvider }
    }
}
