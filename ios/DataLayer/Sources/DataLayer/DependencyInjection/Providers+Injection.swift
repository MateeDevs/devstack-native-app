//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Resolver
import UIKit

public extension Resolver {
    static func registerProviders(
        application: UIApplication,
        appDelegate: (UIApplicationDelegate & UNUserNotificationCenterDelegate),
        networkProviderDelegate: NetworkProviderDelegate
    ) {
        register { FirebaseAnalyticsProvider() as AnalyticsProvider }
        register { RealmDatabaseProvider() as DatabaseProvider }
        register { SystemKeychainProvider() as KeychainProvider }
        register { MoyaNetworkProvider(keychainProvider: resolve(), delegate: networkProviderDelegate) as NetworkProvider }
        register { FirebasePushNotificationsProvider(application: application, appDelegate: appDelegate) as PushNotificationsProvider }
        register { FirebaseRemoteConfigProvider() as RemoteConfigProvider }
        register { SystemUserDefaultsProvider() as UserDefaultsProvider }
    }
}
