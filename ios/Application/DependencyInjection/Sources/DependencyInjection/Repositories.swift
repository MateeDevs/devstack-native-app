//
//  Created by Petr Chmelar on 06.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import AnalyticsToolkit
import AuthToolkit
import Factory
import LocationToolkit
import PushNotificationsToolkit
import RemoteConfigToolkit
import RocketToolkit
import SharedDomain
import StoreKitToolkit
import UserToolkit

public extension Container {
    var analyticsRepository: Factory<AnalyticsRepository> { self { AnalyticsRepositoryImpl(
        analyticsProvider: self.analyticsProvider()
    )}}
    var authRepository: Factory<AuthRepository> { self { AuthRepositoryImpl(
        databaseProvider: self.databaseProvider(),
        keychainProvider: self.keychainProvider(),
        networkProvider: self.networkProvider()
    )}}
    var locationRepository: Factory<LocationRepository> { self { LocationRepositoryImpl(
        locationProvider: self.locationProvider()
    )}}
    var pushNotificationsRepository: Factory<PushNotificationsRepository> { self { PushNotificationsRepositoryImpl(
        pushNotificationsProvider: self.pushNotificationsProvider()
    )}}
    var remoteConfigRepository: Factory<RemoteConfigRepository> { self { RemoteConfigRepositoryImpl(
        remoteConfigProvider: self.remoteConfigProvider()
    )}}
    var rocketLaunchRepository: Factory<RocketLaunchRepository> { self { RocketLaunchRepositoryImpl(
        graphQLProvider: self.graphQLProvider()
    )}}
    var userRepository: Factory<UserRepository> { self { UserRepositoryImpl(
        databaseProvider: self.databaseProvider(),
        networkProvider: self.networkProvider()
    )}}
    var storeKitRepository: Factory<StoreKitRepository> { self { StoreKitRepositoryImpl(
        storeKitProvider: self.storeKitProvider()
    )}}
}
