//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Resolver

public extension Resolver {
    static func registerRepositories() {
        register { AnalyticsRepositoryImpl() as AnalyticsRepository }
        register { AuthTokenRepositoryImpl() as AuthTokenRepository }
        register { LocationRepositoryImpl() as LocationRepository }
        register { PushNotificationsRepositoryImpl() as PushNotificationsRepository }
        register { RemoteConfigRepositoryImpl() as RemoteConfigRepository }
        register { UserRepositoryImpl() as UserRepository }
    }
}
