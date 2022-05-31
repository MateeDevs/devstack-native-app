//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import OSLog
import UserNotifications

public struct PushNotificationsRepositoryImpl: PushNotificationsRepository {
    
    private let pushNotifications: PushNotificationsProvider
    
    public init(pushNotificationsProvider: PushNotificationsProvider) {
        pushNotifications = pushNotificationsProvider
    }
    
    public func decode(_ notificationData: [AnyHashable: Any]) throws -> PushNotification {
        let jsonData = try JSONSerialization.data(withJSONObject: notificationData)
        let notification = try JSONDecoder().decode(NETPushNotification.self, from: jsonData)
        Logger.networking.info("PushNotificationsRepository: Notification received:\n\(jsonData)")
        return notification.domainModel
    }
    
    public func register(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        pushNotifications.requestAuthorization(options: options, completionHandler: completionHandler)
    }
}
