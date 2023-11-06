//
//  Created by Petr Chmelar on 30.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

#if DEBUG
import CoreLocation
import Resolver
@testable import SharedDomain

public extension Resolver {
    static func registerUseCaseMocks() {
        
        // Analytics
        register { TrackAnalyticsEventUseCaseSpy() as TrackAnalyticsEventUseCase }

        // Auth
        let getProfileIdUseCaseSpy = GetProfileIdUseCaseSpy()
        getProfileIdUseCaseSpy.executeReturnValue = AuthToken.stub.userId
        register { getProfileIdUseCaseSpy as GetProfileIdUseCase }
        
        let isUserLoggedUseCaseSpy = IsUserLoggedUseCaseSpy()
        isUserLoggedUseCaseSpy.executeReturnValue = true
        register { isUserLoggedUseCaseSpy as IsUserLoggedUseCase }
        
        register { LoginUseCaseSpy() as LoginUseCase }
        register { LogoutUseCaseSpy() as LogoutUseCase }
        register { RegistrationUseCaseSpy() as RegistrationUseCase }
        
        // Location
        let getCurrentLocationUseCaseSpy = GetCurrentLocationUseCaseSpy()
        getCurrentLocationUseCaseSpy.executeReturnValue = AsyncStream(CLLocation.self) { continuation in
            continuation.yield(CLLocation(latitude: 50.0, longitude: 50.0))
            continuation.finish()
        }
        register { getCurrentLocationUseCaseSpy as GetCurrentLocationUseCase }
        
        // Profile
        let getProfileUseCaseSpy = GetProfileUseCaseSpy()
        getProfileUseCaseSpy.executeReturnValue = User.stub
        register { getProfileUseCaseSpy as GetProfileUseCase }
        
        register { UpdateProfileCounterUseCaseSpy() as UpdateProfileCounterUseCase }
        
        // PushNotification
        let handlePushNotificationUseCaseSpy = HandlePushNotificationUseCaseSpy()
        handlePushNotificationUseCaseSpy.executeReturnValue = PushNotification.stub
        register { handlePushNotificationUseCaseSpy as HandlePushNotificationUseCase }
        
        register { RegisterForPushNotificationsUseCaseSpy() as RegisterForPushNotificationsUseCase }
        
        // RemoteConfig
        let getRemoteConfigValueUseCaseSpy = GetRemoteConfigValueUseCaseSpy()
        getRemoteConfigValueUseCaseSpy.executeReturnValue = true
        register { getRemoteConfigValueUseCaseSpy as GetRemoteConfigValueUseCase }
        
        // Rocket
        let getRocketLaunchesUseCaseSpy = GetRocketLaunchesUseCaseSpy()
        getRocketLaunchesUseCaseSpy.executeReturnValue = AsyncThrowingStream<[RocketLaunch], Error> { continuation in
            continuation.yield([RocketLaunch].stub)
            continuation.finish()
        }
        register { getRocketLaunchesUseCaseSpy as GetRocketLaunchesUseCase }
        
        // User
        let getUsersUseCaseSpy = GetUsersUseCaseSpy()
        getUsersUseCaseSpy.executePageReturnValue = [User].stub
        register { getUsersUseCaseSpy as GetUsersUseCase }
        
        let getUserUseCaseSpy = GetUserUseCaseSpy()
        getUserUseCaseSpy.executeIdReturnValue = User.stub
        register { getUserUseCaseSpy as GetUserUseCase }
        
        register { UpdateUserUseCaseSpy() as UpdateUserUseCase }
        
        // Validation
        register { ValidateEmailUseCaseSpy() as ValidateEmailUseCase }
        register { ValidatePasswordUseCaseSpy() as ValidatePasswordUseCase }
    }
}
#endif
