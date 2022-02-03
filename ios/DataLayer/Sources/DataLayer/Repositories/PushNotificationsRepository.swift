//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import Resolver
import UserNotifications

public struct PushNotificationsRepositoryImpl: PushNotificationsRepository {
    
    @Injected private var pushNotifications: PushNotificationsProvider
    
    public func decode(_ notificationData: [AnyHashable: Any]) -> PushNotification? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: notificationData, options: [])
            let notification = try JSONDecoder().decode(NETPushNotification.self, from: jsonData)
            Logger.info("PushNotificationsRepository: Notification received:\n%@", "\(notification)", category: .networking)
            return notification.domainModel
        } catch let error {
            Logger.error("PushNotificationsRepository: Error during notification decoding:\n%@", "\(error)", category: .networking)
            return nil
        }
    }
    
    public func register(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        pushNotifications.requestAuthorization(options: options, completionHandler: completionHandler)
    }
}
