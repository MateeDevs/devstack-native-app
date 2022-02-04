//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import UserNotifications

public protocol RegisterForPushNotificationsUseCase: AutoMockable {
    func execute(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
}

public struct RegisterForPushNotificationsUseCaseImpl: RegisterForPushNotificationsUseCase {
    
    @Injected private var pushNotificationsRepository: PushNotificationsRepository

    public func execute(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        pushNotificationsRepository.register(
            options: options,
            completionHandler: completionHandler
        )
    }
}
