//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
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
import Resolver
import SharedDomain
import UIKit
import UserDefaultsProvider
import Utilities

public extension Resolver {
    static func registerProviders(
        application: UIApplication,
        networkProviderDelegate: NetworkProviderDelegate,
        pushNotificationsProviderDelegate: PushNotificationsProviderDelegate
    ) {
        register { FirebaseAnalyticsProvider() as AnalyticsProvider }
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
        register {
            FirebasePushNotificationsProvider(
                application: application,
                delegate: pushNotificationsProviderDelegate
            ) as PushNotificationsProvider
        }
        register { FirebaseRemoteConfigProvider(debugMode: Environment.type != .production) as RemoteConfigProvider }
        register { SystemUserDefaultsProvider() as UserDefaultsProvider }
    }
}

public class ProviderContainer: SharedContainer {
    static let analyticsProvider = Factory { FirebaseAnalyticsProvider() as AnalyticsProvider }
    static let databaseProvider = Factory { RealmDatabaseProvider() as DatabaseProvider }
    static let graphQLProvider = Factory { ApolloGraphQLProvider(baseURL: NetworkingConstants.rocketsURL) as GraphQLProvider }
    static let keychainProvider = Factory { SystemKeychainProvider() as KeychainProvider }
    static let locationProvider = Factory { SystemLocationProvider() as LocationProvider }
    static let networkProvider = Factory {
        SystemNetworkProvider(
            readAuthToken: {
                let keychainProvider: KeychainProvider = keychainProvider()
                return try keychainProvider.read(.authToken)
            },
            delegate: UIApplication.shared.delegate! as? NetworkProviderDelegate
        ) as NetworkProvider
    }
    static let pushNotificationsProvider = Factory {
        FirebasePushNotificationsProvider(
            application: UIApplication.shared,
            delegate: UIApplication.shared.delegate! as? PushNotificationsProviderDelegate
        ) as PushNotificationsProvider
    }
    static let remoteConfigProvider = Factory {
        FirebaseRemoteConfigProvider(
            debugMode: Environment.type != .production
        ) as RemoteConfigProvider
    }
    static let userDefaultsProvider = Factory { SystemUserDefaultsProvider() as UserDefaultsProvider }
}
