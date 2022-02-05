//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol HandlePushNotificationUseCase: AutoMockable {
    func execute(_ notificationData: [AnyHashable: Any]) -> PushNotification?
}

public struct HandlePushNotificationUseCaseImpl: HandlePushNotificationUseCase {
    
    private let pushNotificationsRepository: PushNotificationsRepository
    
    public init(pushNotificationsRepository: PushNotificationsRepository) {
        self.pushNotificationsRepository = pushNotificationsRepository
    }
    
    public func execute(_ notificationData: [AnyHashable: Any]) -> PushNotification? {
        pushNotificationsRepository.decode(notificationData)
    }
}
