//
//  Created by Petr Chmelar on 30.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

// swiftlint:disable line_length

#if DEBUG
import CoreLocation
import Resolver
import SharedDomain

public extension Resolver {
    static func registerUseCaseMocks() {
        // Analytics
        register { TrackAnalyticsEventUseCaseMock() as TrackAnalyticsEventUseCase }

        // Auth
        register { GetProfileIdUseCaseMock(executeReturnValue: AuthToken.stub.userId) as GetProfileIdUseCase }
        register { IsUserLoggedUseCaseMock(executeReturnValue: true) as IsUserLoggedUseCase }
        register { LoginUseCaseMock() as LoginUseCase }
        register { LogoutUseCaseMock() as LogoutUseCase }
        register { RegistrationUseCaseMock() as RegistrationUseCase }
        
        // Location
        register { GetCurrentLocationUseCaseMock(executeReturnValue: AsyncStream(CLLocation.self) { continuation in
            continuation.yield(CLLocation(latitude: 50.0, longitude: 50.0))
            continuation.finish()
        }) as GetCurrentLocationUseCase }
        
        // Profile
        register { GetProfileUseCaseMock(executeReturnValue: User.stub) as GetProfileUseCase }
        register { UpdateProfileCounterUseCaseMock() as UpdateProfileCounterUseCase }
        
        // PushNotification
        register { HandlePushNotificationUseCaseMock(executeReturnValue: PushNotification.stub) as HandlePushNotificationUseCase }
        register { RegisterForPushNotificationsUseCaseMock() as RegisterForPushNotificationsUseCase }
        
        // RemoteConfig
        register { GetRemoteConfigValueUseCaseMock(executeReturnValue: true) as GetRemoteConfigValueUseCase}
        
        // User
        register { GetUsersUseCaseMock(executePageReturnValue: [User].stub) as GetUsersUseCase }
        register { GetUserUseCaseMock(executeIdReturnValue: User.stub) as GetUserUseCase }
        register { UpdateUserUseCaseMock() as UpdateUserUseCase }
        
        // Validation
        register { ValidateEmailUseCaseMock() as ValidateEmailUseCase }
        register { ValidatePasswordUseCaseMock() as ValidatePasswordUseCase }
    }
}
#endif
