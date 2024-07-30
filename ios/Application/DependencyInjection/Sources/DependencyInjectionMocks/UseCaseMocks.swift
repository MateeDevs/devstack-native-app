//
//  Created by Petr Chmelar on 07.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

#if DEBUG
import CoreLocation
import DependencyInjection
import KMPShared
import Factory
@testable import SharedDomain
import SharedDomainMocks

public extension Container {
    func registerUseCaseMocks() {
        
        // Analytics
        trackAnalyticsEventUseCase.register { TrackAnalyticsEventUseCaseSpy() }
        
        // Auth
        let getProfileIdUseCaseSpy = GetProfileIdUseCaseSpy()
        getProfileIdUseCaseSpy.executeReturnValue = AuthToken.stub.userId
        getProfileIdUseCase.register { getProfileIdUseCaseSpy }
        
        let isUserLoggedUseCaseSpy = IsUserLoggedUseCaseSpy()
        isUserLoggedUseCaseSpy.executeReturnValue = true
        isUserLoggedUseCase.register { isUserLoggedUseCaseSpy }
        
        loginUseCase.register { LoginUseCaseSpy() }
        logoutUseCase.register { LogoutUseCaseSpy() }
        registrationUseCase.register { RegistrationUseCaseSpy() }
        
        // Books
        getBooksUseCase.register { GetBooksUseCaseMock(executeReturnValue: .stub) }
        refreshBooksUseCase.register { RefreshBooksUseCaseMock() }
        
        // Location
        let getCurrentLocationUseCaseSpy = GetCurrentLocationUseCaseSpy()
        getCurrentLocationUseCaseSpy.executeReturnValue = AsyncStream(CLLocation.self) { continuation in
            continuation.yield(CLLocation(latitude: 50.0, longitude: 50.0))
            continuation.finish()
        }
        getCurrentLocationUseCase.register { getCurrentLocationUseCaseSpy }
        
        // Profile
        let getProfileUseCaseSpy = GetProfileUseCaseSpy()
        getProfileUseCaseSpy.executeReturnValue = .stub
        getProfileUseCase.register { getProfileUseCaseSpy }
        
        updateProfileCounterUseCase.register { UpdateProfileCounterUseCaseSpy() }
        
        // PushNotification
        let handlePushNotificationUseCaseSpy = HandlePushNotificationUseCaseSpy()
        handlePushNotificationUseCaseSpy.executeReturnValue = .stub
        handlePushNotificationUseCase.register { handlePushNotificationUseCaseSpy }
        
        registerForPushNotificationsUseCase.register { RegisterForPushNotificationsUseCaseSpy() }
        
        // RemoteConfig
        let getRemoteConfigValueUseCaseSpy = GetRemoteConfigValueUseCaseSpy()
        getRemoteConfigValueUseCaseSpy.executeReturnValue = true
        getRemoteConfigValueUseCase.register { getRemoteConfigValueUseCaseSpy }
        
        // Rocket
        let getRocketLaunchesUseCaseSpy = GetRocketLaunchesUseCaseSpy()
        getRocketLaunchesUseCaseSpy.executeReturnValue = AsyncThrowingStream<[RocketLaunch], Error> { continuation in
            continuation.yield([RocketLaunch].stub)
            continuation.finish()
        }
        getRocketLaunchesUseCase.register { getRocketLaunchesUseCaseSpy }
        
        // User
        let getUsersUseCaseSpy = GetUsersUseCaseSpy()
        getUsersUseCaseSpy.executePageReturnValue = .stub
        getUsersUseCase.register { getUsersUseCaseSpy }
        
        let getUserUseCaseSpy = GetUserUseCaseSpy()
        getUserUseCaseSpy.executeIdReturnValue = .stub
        getUserUseCase.register { getUserUseCaseSpy }
        
        updateUserUseCase.register { UpdateUserUseCaseSpy() }
        
        // Validation
        validateEmailUseCase.register { ValidateEmailUseCaseSpy() }
        validatePasswordUseCase.register { ValidatePasswordUseCaseSpy() }
    }
}
#endif
