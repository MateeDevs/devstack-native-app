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
import UserToolkit

public extension Resolver {
    static func registerDependencies() {
        // UseCases
        register { GetProfileIdUseCaseImpl(authRepository: resolve()) as GetProfileIdUseCase }
        register { GetUserUseCaseImpl(userRepository: resolve()) as GetUserUseCase }
        register { GetProfileUseCaseImpl(getProfileIdUseCase: resolve(), getUserUseCase: resolve()) as GetProfileUseCase }
        
        // Repositories
        register {
            AuthRepositoryImpl(
                databaseProvider: resolve(),
                keychainProvider: resolve(),
                networkProvider: resolve(),
                userDefaultsProvider: resolve()
            ) as AuthRepository
        }
        
        register {
            UserRepositoryImpl(
                databaseProvider: resolve(),
                networkProvider: resolve()
            ) as UserRepository
        }
        
        // Providers
        register { RealmDatabaseProvider() as DatabaseProvider }
        register { SystemKeychainProvider() as KeychainProvider }
        
        register {
            SystemNetworkProvider(
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
