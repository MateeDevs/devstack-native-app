//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import AnalyticsProvider
import KeychainProvider
import NetworkProvider
import PushNotificationsProvider
import Resolver
import SharedDomain
import UIKit
import Utilities

public extension Resolver {
    static func registerProviders(
        application: UIApplication,
        appDelegate: (UIApplicationDelegate & UNUserNotificationCenterDelegate),
        networkProviderDelegate: NetworkProviderDelegate
    ) {
        register { FirebaseAnalyticsProvider() as AnalyticsProvider }
        register { SystemKeychainProvider() as KeychainProvider }
        
        register {
            SystemNetworkProvider(
                readAuthToken: {
                    let keychainProvider: KeychainProvider = Resolver.resolve()
                    return try keychainProvider.read(.authToken)
                },
                delegate: networkProviderDelegate
            ) as NetworkProvider
        }
        
        register { FirebasePushNotificationsProvider(application: application, appDelegate: appDelegate) as PushNotificationsProvider }
    }
}
