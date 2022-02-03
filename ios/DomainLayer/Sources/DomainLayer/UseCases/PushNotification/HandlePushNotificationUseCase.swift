//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver

public protocol HasHandlePushNotificationUseCase {
    var handlePushNotificationUseCase: HandlePushNotificationUseCase { get }
}

public protocol HandlePushNotificationUseCase: AutoMockable {
    func execute(_ notificationData: [AnyHashable: Any]) -> PushNotification?
}

public struct HandlePushNotificationUseCaseImpl: HandlePushNotificationUseCase {
    
    @Injected private var pushNotificationsRepository: PushNotificationsRepository
    
    public func execute(_ notificationData: [AnyHashable: Any]) -> PushNotification? {
        pushNotificationsRepository.decode(notificationData)
    }
}
