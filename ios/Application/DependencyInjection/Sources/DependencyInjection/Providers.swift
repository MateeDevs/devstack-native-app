//
//  Created by Petr Chmelar on 06.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import AnalyticsProvider
import DatabaseProvider
import Factory
import GraphQLProvider
import KeychainProvider
import LocationProvider
import NetworkProvider
import PushNotificationsProvider
import RemoteConfigProvider
import StoreKitProvider
import UIKit
import UserDefaultsProvider
import Utilities

public extension Container {
    var analyticsProvider: Factory<AnalyticsProvider> { self { FirebaseAnalyticsProvider() } }
    var databaseProvider: Factory<DatabaseProvider> { self { RealmDatabaseProvider() } }
    var graphQLProvider: Factory<GraphQLProvider> { self { ApolloGraphQLProvider(
        baseURL: NetworkingConstants.rocketsURL
    )}}
    var keychainProvider: Factory<KeychainProvider> { self { SystemKeychainProvider() } }
    var locationProvider: Factory<LocationProvider> { self { SystemLocationProvider() } }
    var networkProvider: Factory<NetworkProvider> { self { SystemNetworkProvider(
        readAuthToken: { try self.keychainProvider().read(.authToken) },
        delegate: UIApplication.shared.delegate as? NetworkProviderDelegate
    )}}
    var pushNotificationsProvider: Factory<PushNotificationsProvider> { self { FirebasePushNotificationsProvider(
        application: UIApplication.shared,
        appDelegate: UIApplication.shared.delegate as? (UIApplicationDelegate & UNUserNotificationCenterDelegate)
    )}}
    var remoteConfigProvider: Factory<RemoteConfigProvider> { self { FirebaseRemoteConfigProvider(
        debugMode: Environment.type != .production
    )}}
    var userDefaultsProvider: Factory<UserDefaultsProvider> { self { SystemUserDefaultsProvider() } }
    var storeKitProvider: Factory<StoreKitProvider> { self { AppleStoreKitProvider() } }
}
