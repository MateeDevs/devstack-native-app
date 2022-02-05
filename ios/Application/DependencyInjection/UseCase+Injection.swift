//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

// swiftlint:disable line_length

import DomainLayer
import Resolver

public extension Resolver {
    static func registerUseCases() {
        // Analytics
        register { TrackAnalyticsEventUseCaseImpl(analyticsRepository: resolve()) as TrackAnalyticsEventUseCase }
        
        // Auth
        register { LoginUseCaseImpl(authTokenRepository: resolve()) as LoginUseCase }
        register { LogoutUseCaseImpl(authTokenRepository: resolve()) as LogoutUseCase }
        register { RegistrationUseCaseImpl(userRepository: resolve()) as RegistrationUseCase }
        
        // Location
        register { GetCurrentLocationUseCaseImpl(locationRepository: resolve()) as GetCurrentLocationUseCase }
        
        // Profile
        register { GetProfileUseCaseImpl(authTokenRepository: resolve(), userRepository: resolve()) as GetProfileUseCase }
        register { GetProfileIdUseCaseImpl(authTokenRepository: resolve()) as GetProfileIdUseCase }
        register { RefreshProfileUseCaseImpl(authTokenRepository: resolve(), userRepository: resolve()) as RefreshProfileUseCase }
        register { UpdateProfileCounterUseCaseImpl(authTokenRepository: resolve(), userRepository: resolve()) as UpdateProfileCounterUseCase }
        
        // PushNotification
        register { HandlePushNotificationUseCaseImpl(pushNotificationsRepository: resolve()) as HandlePushNotificationUseCase }
        register { RegisterForPushNotificationsUseCaseImpl(pushNotificationsRepository: resolve()) as RegisterForPushNotificationsUseCase }
        
        // RemoteConfig
        register { GetRemoteConfigValueUseCaseImpl(remoteConfigRepository: resolve()) as GetRemoteConfigValueUseCase }
        
        // User
        register { GetUserUseCaseImpl(userRepository: resolve()) as GetUserUseCase }
        register { RefreshUserUseCaseImpl(userRepository: resolve()) as RefreshUserUseCase }
        register { UpdateUserUseCaseImpl(userRepository: resolve()) as UpdateUserUseCase }
        
        // Users
        register { GetUsersUseCaseImpl(userRepository: resolve()) as GetUsersUseCase }
        register { RefreshUsersUseCaseImpl(userRepository: resolve()) as RefreshUsersUseCase }
    }
}
