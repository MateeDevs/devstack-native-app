//
//  Created by Petr Chmelar on 22.11.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol RepositoryDependency: HasNoRepository,
    HasAnalyticsRepository,
    HasAuthTokenRepository,
    HasLocationRepository,
    HasPushNotificationsRepository,
    HasRemoteConfigRepository,
    HasUserRepository {}
