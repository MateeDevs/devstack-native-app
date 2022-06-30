//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import AnalyticsProvider
import DatabaseProvider
import GraphQLProvider
import KeychainProvider
import LocationProvider
import NetworkProvider
import PushNotificationsProvider
import RemoteConfigProvider
import Resolver
import SharedDomain
import UIKit
import UserDefaultsProvider
import Utilities

public extension Resolver {
    static func registerProviders(
        application: UIApplication,
        appDelegate: (UIApplicationDelegate & UNUserNotificationCenterDelegate),
        networkProviderDelegate: NetworkProviderDelegate
    ) {
        register {
            FirebaseAnalyticsProvider(
                debugMode: Environment.type != .production,
                processInfo: ProcessInfo.processInfo
            ) as AnalyticsProvider
        }
        register { RealmDatabaseProvider() as DatabaseProvider }
        register { ApolloGraphQLProvider(baseURL: NetworkingConstants.rocketsURL) as GraphQLProvider }
        register { SystemKeychainProvider() as KeychainProvider }
        register { SystemLocationProvider() as LocationProvider }
        
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
        register { FirebaseRemoteConfigProvider(debugMode: Environment.type != .production) as RemoteConfigProvider }
        register { SystemUserDefaultsProvider() as UserDefaultsProvider }
    }
}
