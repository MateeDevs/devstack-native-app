//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain
import UserNotifications

public protocol PushNotificationsProviderDelegate: AnyObject {
    func didReceive(_ notification: [AnyHashable: Any])
}

// sourcery: AutoMockable
public protocol PushNotificationsProvider {
    
    var delegate: PushNotificationsProviderDelegate? { get set }
    
    /// Request user's authorization for push notifications
    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
}
