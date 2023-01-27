//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

// swiftlint:disable line_length

import Resolver
import SharedDomain

public extension Resolver {
    static func registerUseCases() {
        // Analytics
        register { TrackAnalyticsEventUseCaseImpl(analyticsRepository: resolve()) as TrackAnalyticsEventUseCase }
        
        // PushNotification
        register { HandlePushNotificationUseCaseImpl(pushNotificationsRepository: resolve()) as HandlePushNotificationUseCase }
        register { RegisterForPushNotificationsUseCaseImpl(pushNotificationsRepository: resolve()) as RegisterForPushNotificationsUseCase }
    }
}
