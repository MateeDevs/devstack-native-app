//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Spyable

@Spyable
public protocol HandlePushNotificationUseCase {
    func execute(_ notificationData: [AnyHashable: Any]) throws -> PushNotification
}

public struct HandlePushNotificationUseCaseImpl: HandlePushNotificationUseCase {
    
    private let pushNotificationsRepository: PushNotificationsRepository
    
    public init(pushNotificationsRepository: PushNotificationsRepository) {
        self.pushNotificationsRepository = pushNotificationsRepository
    }
    
    public func execute(_ notificationData: [AnyHashable: Any]) throws -> PushNotification {
        try pushNotificationsRepository.decode(notificationData)
    }
}
