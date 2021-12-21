//
//  Created by Petr Chmelar on 23/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer

public struct ProviderDependencyMock: ProviderDependency {
    
    public let analyticsProvider: AnalyticsProvider
    public let databaseProvider: DatabaseProvider
    public let keychainProvider: KeychainProvider
    public let networkProvider: NetworkProvider
    public let pushNotificationsProvider: PushNotificationsProvider
    public let remoteConfigProvider: RemoteConfigProvider
    public let userDefaultsProvider: UserDefaultsProvider
    
    public init(
        analyticsProvider: AnalyticsProvider = AnalyticsProviderMock(),
        databaseProvider: DatabaseProvider = DatabaseProviderMock(),
        keychainProvider: KeychainProvider = KeychainProviderMock(),
        networkProvider: NetworkProvider = NetworkProviderMock(),
        pushNotificationsProvider: PushNotificationsProvider = PushNotificationsProviderMock(),
        remoteConfigProvider: RemoteConfigProvider = RemoteConfigProviderMock(),
        userDefaultsProvider: UserDefaultsProvider = UserDefaultsProviderMock()
    ) {
        self.analyticsProvider = analyticsProvider
        self.databaseProvider = databaseProvider
        self.keychainProvider = keychainProvider
        self.networkProvider = networkProvider
        self.pushNotificationsProvider = pushNotificationsProvider
        self.remoteConfigProvider = remoteConfigProvider
        self.userDefaultsProvider = userDefaultsProvider
    }
}
