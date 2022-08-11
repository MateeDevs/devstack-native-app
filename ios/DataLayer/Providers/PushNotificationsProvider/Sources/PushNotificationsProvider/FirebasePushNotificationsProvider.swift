//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Firebase
import FirebaseMessaging
import OSLog
import SharedDomain
import UIKit
import UserNotifications

public final class FirebasePushNotificationsProvider: NSObject {
    
    private let application: UIApplication
    private weak var _delegate: PushNotificationsProviderDelegate?
    
    public init(
        application: UIApplication,
        delegate: PushNotificationsProviderDelegate?
    ) {
        self.application = application
        self._delegate = delegate
        super.init()
        
        // Start Firebase if not yet started
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // Setup delegates
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
    }
}

extension FirebasePushNotificationsProvider: PushNotificationsProvider {
    
    public var delegate: PushNotificationsProviderDelegate? {
        get {
            _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    public func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: completionHandler)
        application.registerForRemoteNotifications()
    }
}

extension FirebasePushNotificationsProvider: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Show system notification
        completionHandler([.list, .banner, .badge, .sound])
    }
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let notification = response.notification.request.content.userInfo
        delegate?.didReceive(notification)
    }
}

extension FirebasePushNotificationsProvider: MessagingDelegate {
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Logger(subsystem: Bundle.main.bundleIdentifier ?? "-", category: "PushNotificationsProvider")
            .info("FirebaseMessaging registration token:\n\(fcmToken ?? "")")
    }
}
