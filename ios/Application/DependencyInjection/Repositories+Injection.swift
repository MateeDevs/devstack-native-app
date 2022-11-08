//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import AnalyticsToolkit
import AuthToolkit
import LocationToolkit
import PushNotificationsToolkit
import RemoteConfigToolkit
import Resolver
import RocketToolkit
import SharedDomain
import UserToolkit

public extension Resolver {
    static func registerRepositories() {
        register { AnalyticsRepositoryImpl(analyticsProvider: resolve()) as AnalyticsRepository }
        
        register {
            AuthRepositoryImpl(
                databaseProvider: resolve(),
                keychainProvider: resolve(),
                networkProvider: resolve(),
                userDefaultsProvider: resolve()
            ) as AuthRepository
        }
        
        register { LocationRepositoryImpl(locationProvider: resolve()) as LocationRepository }
        
        register { PushNotificationsRepositoryImpl(pushNotificationsProvider: resolve()) as PushNotificationsRepository }
        
        register { RemoteConfigRepositoryImpl(remoteConfigProvider: resolve()) as RemoteConfigRepository }
        
        register { RocketLaunchRepositoryImpl(graphQLProvider: resolve()) as RocketLaunchRepository }
        
        register {
            UserRepositoryImpl(
                databaseProvider: resolve(),
                networkProvider: resolve()
            ) as UserRepository
        }
    }
}
