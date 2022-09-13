//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

// swiftlint:disable line_length

import Resolver
import SharedDomain

public extension Resolver {
    static func registerUseCases() {
        // Analytics
        register { TrackAnalyticsEventUseCaseImpl(analyticsRepository: resolve()) as TrackAnalyticsEventUseCase }
        
        // Auth
        register { GetProfileIdUseCaseImpl(authRepository: resolve()) as GetProfileIdUseCase }
        register { IsUserLoggedUseCaseImpl(getProfileIdUseCase: resolve()) as IsUserLoggedUseCase }
        register { LoginUseCaseImpl(authRepository: resolve(), validateEmailUseCase: resolve(), validatePasswordUseCase: resolve()) as LoginUseCase }
        register { LogoutUseCaseImpl(authRepository: resolve()) as LogoutUseCase }
        register { RegistrationUseCaseImpl(authRepository: resolve(), validateEmailUseCase: resolve(), validatePasswordUseCase: resolve()) as RegistrationUseCase }
        
        // Location
        register { GetCurrentLocationUseCaseImpl(locationRepository: resolve()) as GetCurrentLocationUseCase }
        
        // Profile
        register { GetProfileUseCaseImpl(getProfileIdUseCase: resolve(), getUserUseCase: resolve()) as GetProfileUseCase }
        register { UpdateProfileCounterUseCaseImpl(getProfileIdUseCase: resolve(), getUserUseCase: resolve(), updateUserUseCase: resolve()) as UpdateProfileCounterUseCase }
        
        // PushNotification
        register { HandlePushNotificationUseCaseImpl(pushNotificationsRepository: resolve()) as HandlePushNotificationUseCase }
        register { RegisterForPushNotificationsUseCaseImpl(pushNotificationsRepository: resolve()) as RegisterForPushNotificationsUseCase }
        
        // RemoteConfig
        register { GetRemoteConfigValueUseCaseImpl(remoteConfigRepository: resolve()) as GetRemoteConfigValueUseCase }
        
        // Rocket
        register { GetRocketLaunchesUseCaseImpl(rocketLaunchRepository: resolve()) as GetRocketLaunchesUseCase }
        
        // User
        register { GetUsersUseCaseImpl(userRepository: resolve()) as GetUsersUseCase }
        register { GetUserUseCaseImpl(userRepository: resolve()) as GetUserUseCase }
        register { UpdateUserUseCaseImpl(userRepository: resolve(), validateFirstNameUseCase: resolve(), validateLastNameUseCase: resolve(), validatePhoneUseCase: resolve()) as UpdateUserUseCase }
        
        // Validation
        register { ValidateEmailUseCaseImpl() as ValidateEmailUseCase }
        register { ValidatePasswordUseCaseImpl() as ValidatePasswordUseCase }
        register { ValidateFirstNameUseCaseImpl() as ValidateFirstNameUseCase }
        register { ValidateLastNameUseCaseImpl() as ValidateLastNameUseCase }
        register { ValidatePhoneUseCaseImpl() as ValidatePhoneUseCase }
    }
}
