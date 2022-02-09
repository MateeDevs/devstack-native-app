//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DataLayer
import DomainLayer
import Resolver

public extension Resolver {
    static func registerRepositories() {
        register { AnalyticsRepositoryImpl(analyticsProvider: resolve()) as AnalyticsRepository }
        
        register {
            AuthTokenRepositoryImpl(
                databaseProvider: resolve(),
                keychainProvider: resolve(),
                networkProvider: resolve()
            ) as AuthTokenRepository
        }
        
        register { LocationRepositoryImpl() as LocationRepository }
        
        register { PushNotificationsRepositoryImpl(pushNotificationsProvider: resolve()) as PushNotificationsRepository }
        
        register { RemoteConfigRepositoryImpl(remoteConfigProvider: resolve()) as RemoteConfigRepository }
        
        register { UserRepositoryImpl(databaseProvider: resolve(), networkProvider: resolve()) as UserRepository }
    }
}
