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
        register { SystemKeychainProvider(userDefaultsProvider: resolve()) as KeychainProvider }
        register { SystemNetworkProvider(keychainProvider: resolve(), delegate: nil) as NetworkProvider }
        register { SystemUserDefaultsProvider() as UserDefaultsProvider }
    }
}
