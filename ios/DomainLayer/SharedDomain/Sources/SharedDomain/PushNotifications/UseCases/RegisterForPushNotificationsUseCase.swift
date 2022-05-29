//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import UserNotifications

// sourcery: AutoMockable
public protocol RegisterForPushNotificationsUseCase {
    func execute(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
}

public struct RegisterForPushNotificationsUseCaseImpl: RegisterForPushNotificationsUseCase {
    
    private let pushNotificationsRepository: PushNotificationsRepository
    
    public init(pushNotificationsRepository: PushNotificationsRepository) {
        self.pushNotificationsRepository = pushNotificationsRepository
    }

    public func execute(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        pushNotificationsRepository.register(
            options: options,
            completionHandler: completionHandler
        )
    }
}
