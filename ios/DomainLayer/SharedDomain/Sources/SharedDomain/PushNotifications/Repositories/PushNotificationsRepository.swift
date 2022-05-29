//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import UserNotifications

// sourcery: AutoMockable
public protocol PushNotificationsRepository {
    func decode(_ notificationData: [AnyHashable: Any]) throws -> PushNotification
    func register(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
}
