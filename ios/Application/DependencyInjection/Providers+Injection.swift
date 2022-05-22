//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer
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
        register { SystemKeychainProvider(userDefaultsProvider: resolve()) as KeychainProvider }
        register { SystemLocationProvider() as LocationProvider }
        register { SystemNetworkProvider(keychainProvider: resolve(), delegate: networkProviderDelegate) as NetworkProvider }
        register { FirebasePushNotificationsProvider(application: application, appDelegate: appDelegate) as PushNotificationsProvider }
        register { FirebaseRemoteConfigProvider() as RemoteConfigProvider }
        register { SystemUserDefaultsProvider() as UserDefaultsProvider }
    }
}
