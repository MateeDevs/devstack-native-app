//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import Firebase
import UIKit
import UserNotifications

public class FirebasePushNotificationsProvider: NSObject {
    
    private let application: UIApplication
    
    public init(application: UIApplication, appDelegate: (UIApplicationDelegate & UNUserNotificationCenterDelegate)) {
        self.application = application
        super.init()
        
        // Start Firebase if not yet started
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // Setup delegates
        UNUserNotificationCenter.current().delegate = appDelegate
        Messaging.messaging().delegate = self
    }
}

extension FirebasePushNotificationsProvider: PushNotificationsProvider {
    public func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: completionHandler)
        application.registerForRemoteNotifications()
    }
}

extension FirebasePushNotificationsProvider: MessagingDelegate {
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Logger.info("PushNotificationsProvider: FirebaseMessaging registration token:\n%@", fcmToken ?? "", category: .networking)
    }
}
