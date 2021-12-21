//
//  Created by Petr Chmelar on 18.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public struct RepositoryDependencyMock: RepositoryDependency {
    
    public let analyticsRepository: AnalyticsRepository
    public let authTokenRepository: AuthTokenRepository
    public let locationRepository: LocationRepository
    public let pushNotificationsRepository: PushNotificationsRepository
    public let remoteConfigRepository: RemoteConfigRepository
    public let userRepository: UserRepository
    
    public init(
        analyticsRepository: AnalyticsRepository = AnalyticsRepositoryMock(),
        authTokenRepository: AuthTokenRepository = AuthTokenRepositoryMock(),
        locationRepository: LocationRepository = LocationRepositoryMock(),
        pushNotificationsRepository: PushNotificationsRepository = PushNotificationsRepositoryMock(),
        remoteConfigRepository: RemoteConfigRepository = RemoteConfigRepositoryMock(),
        userRepository: UserRepository = UserRepositoryMock()
    ) {
        self.analyticsRepository = analyticsRepository
        self.authTokenRepository = authTokenRepository
        self.locationRepository = locationRepository
        self.pushNotificationsRepository = pushNotificationsRepository
        self.remoteConfigRepository = remoteConfigRepository
        self.userRepository = userRepository
    }
}
