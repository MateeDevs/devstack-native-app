//
//  Created by Petr Chmelar on 06.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Factory
import SharedDomain

public extension Container {
    // Analytics
    var trackAnalyticsEventUseCase: Factory<TrackAnalyticsEventUseCase> { self { TrackAnalyticsEventUseCaseImpl(
        analyticsRepository: self.analyticsRepository()
    )}}
    
    // Auth
    var getProfileIdUseCase: Factory<GetProfileIdUseCase> { self { GetProfileIdUseCaseImpl(
        authRepository: self.authRepository()
    )}}
    var isUserLoggedUseCase: Factory<IsUserLoggedUseCase> { self { IsUserLoggedUseCaseImpl(
        getProfileIdUseCase: self.getProfileIdUseCase()
    )}}
    var loginUseCase: Factory<LoginUseCase> { self { LoginUseCaseImpl(
        authRepository: self.authRepository(),
        validateEmailUseCase: self.validateEmailUseCase(),
        validatePasswordUseCase: self.validatePasswordUseCase()
    )}}
    var logoutUseCase: Factory<LogoutUseCase> { self { LogoutUseCaseImpl(
        authRepository: self.authRepository()
    )}}
    var registrationUseCase: Factory<RegistrationUseCase> { self { RegistrationUseCaseImpl(
        authRepository: self.authRepository(),
        validateEmailUseCase: self.validateEmailUseCase(),
        validatePasswordUseCase: self.validatePasswordUseCase()
    )}}
    
    // Location
    var getCurrentLocationUseCase: Factory<GetCurrentLocationUseCase> { self { GetCurrentLocationUseCaseImpl(
        locationRepository: self.locationRepository()
    )}}
    
    // Profile
    var getProfileUseCase: Factory<GetProfileUseCase> { self { GetProfileUseCaseImpl(
        getProfileIdUseCase: self.getProfileIdUseCase(),
        getUserUseCase: self.getUserUseCase()
    )}}
    var updateProfileCounterUseCase: Factory<UpdateProfileCounterUseCase> { self { UpdateProfileCounterUseCaseImpl(
        getProfileIdUseCase: self.getProfileIdUseCase(),
        getUserUseCase: self.getUserUseCase(),
        updateUserUseCase: self.updateUserUseCase()
    )}}
    
    // PushNotification
    var handlePushNotificationUseCase: Factory<HandlePushNotificationUseCase> { self { HandlePushNotificationUseCaseImpl(
        pushNotificationsRepository: self.pushNotificationsRepository()
    )}}
    var registerForPushNotificationsUseCase: Factory<RegisterForPushNotificationsUseCase> { self { RegisterForPushNotificationsUseCaseImpl(
        pushNotificationsRepository: self.pushNotificationsRepository()
    )}}
    
    // RemoteConfig
    var getRemoteConfigValueUseCase: Factory<GetRemoteConfigValueUseCase> { self { GetRemoteConfigValueUseCaseImpl(
        remoteConfigRepository: self.remoteConfigRepository()
    )}}
    
    // Rocket
    var getRocketLaunchesUseCase: Factory<GetRocketLaunchesUseCase> { self { GetRocketLaunchesUseCaseImpl(
        rocketLaunchRepository: self.rocketLaunchRepository()
    )}}
    
    // User
    var getUsersUseCase: Factory<GetUsersUseCase> { self { GetUsersUseCaseImpl(
        userRepository: self.userRepository()
    )}}
    var getUserUseCase: Factory<GetUserUseCase> { self { GetUserUseCaseImpl(
        userRepository: self.userRepository()
    )}}
    var updateUserUseCase: Factory<UpdateUserUseCase> { self { UpdateUserUseCaseImpl(
        userRepository: self.userRepository()
    )}}
    
    // Validation
    var validateEmailUseCase: Factory<ValidateEmailUseCase> { self { ValidateEmailUseCaseImpl() } }
    var validatePasswordUseCase: Factory<ValidatePasswordUseCase> { self { ValidatePasswordUseCaseImpl() } }
    
    // StoreKit
    var requestFeedbackUseCase: Factory<RequestFeedbackUseCase> { self { RequestFeedbackUseCaseImpl(
        storeKitRepository: self.storeKitRepository()
    )}}
}
