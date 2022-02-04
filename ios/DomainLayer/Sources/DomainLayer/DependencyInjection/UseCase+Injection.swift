//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared
import Resolver

public extension Resolver {
    static func registerUseCases(kmpDependencies: KMPDependency) {
        // Analytics
        register { TrackAnalyticsEventUseCaseImpl() as TrackAnalyticsEventUseCase }
        
        // Auth
        register { LoginUseCaseImpl() as LoginUseCase }
        register { LogoutUseCaseImpl() as LogoutUseCase }
        register { RegistrationUseCaseImpl() as RegistrationUseCase }
        
        // Location
        register { GetCurrentLocationUseCaseImpl() as GetCurrentLocationUseCase }
        
        // Profile
        register { GetProfileUseCaseImpl() as GetProfileUseCase }
        register { GetProfileIdUseCaseImpl() as GetProfileIdUseCase }
        register { RefreshProfileUseCaseImpl() as RefreshProfileUseCase }
        register { UpdateProfileCounterUseCaseImpl() as UpdateProfileCounterUseCase }
        
        // PushNotification
        register { HandlePushNotificationUseCaseImpl() as HandlePushNotificationUseCase }
        register { RegisterForPushNotificationsUseCaseImpl() as RegisterForPushNotificationsUseCase }
        
        // RemoteConfig
        register { GetRemoteConfigValueUseCaseImpl() as GetRemoteConfigValueUseCase }
        
        // User
        register { GetUserUseCaseImpl() as GetUserUseCase }
        register { RefreshUserUseCaseImpl() as RefreshUserUseCase }
        register { UpdateUserUseCaseImpl() as UpdateUserUseCase }
        
        // Users
        register { GetUsersUseCaseImpl() as GetUsersUseCase }
        register { RefreshUsersUseCaseImpl() as RefreshUsersUseCase }
        
        // Books
        register { kmpDependencies.getProtocol(GetBooksUseCase.self) as GetBooksUseCase }
        register { kmpDependencies.getProtocol(RefreshBooksUseCase.self) as RefreshBooksUseCase }
    }
}
