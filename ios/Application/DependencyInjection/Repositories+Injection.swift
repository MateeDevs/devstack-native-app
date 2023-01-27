//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import AnalyticsToolkit
import PushNotificationsToolkit
import Resolver
import SharedDomain

public extension Resolver {
    static func registerRepositories() {
        register { AnalyticsRepositoryImpl(analyticsProvider: resolve()) as AnalyticsRepository }
        
        register { PushNotificationsRepositoryImpl(pushNotificationsProvider: resolve()) as PushNotificationsRepository }
    }
}
