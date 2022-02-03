//
//  Created by Petr Chmelar on 24/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer

public struct RepositoryDependencyImpl: RepositoryDependency {
    
    public let analyticsRepository: AnalyticsRepository
    public let authTokenRepository: AuthTokenRepository
    public let locationRepository: LocationRepository
    public let pushNotificationsRepository: PushNotificationsRepository
    public let remoteConfigRepository: RemoteConfigRepository
    public let userRepository: UserRepository
    
    public init() {
        self.analyticsRepository = AnalyticsRepositoryImpl()
        self.authTokenRepository = AuthTokenRepositoryImpl()
        self.locationRepository = LocationRepositoryImpl()
        self.pushNotificationsRepository = PushNotificationsRepositoryImpl()
        self.remoteConfigRepository = RemoteConfigRepositoryImpl()
        self.userRepository = UserRepositoryImpl()
    }
}
