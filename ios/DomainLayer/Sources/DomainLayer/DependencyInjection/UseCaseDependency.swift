//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import protocol DevstackKmpShared.GetBooksUseCase
import protocol DevstackKmpShared.RefreshBooksUseCase

public protocol UseCaseDependency: HasNoUseCase,
    HasTrackAnalyticsEventUseCase,
    HasLoginUseCase,
    HasLogoutUseCase,
    HasRegistrationUseCase,
    HasGetCurrentLocationUseCase,
    HasGetProfileUseCase,
    HasGetProfileIdUseCase,
    HasRefreshProfileUseCase,
    HasUpdateProfileCounterUseCase,
    HasHandlePushNotificationUseCase,
    HasRegisterForPushNotificationsUseCase,
    HasGetRemoteConfigValueUseCase,
    HasGetUserUseCase,
    HasRefreshUserUseCase,
    HasUpdateUserUseCase,
    HasGetUsersUseCase,
    HasRefreshUsersUseCase,
    HasGetBooksUseCase,
    HasRefreshBooksUseCase {}

public struct UseCaseDependencyImpl: UseCaseDependency {
    
    public let trackAnalyticsEventUseCase: TrackAnalyticsEventUseCase
    
    public let loginUseCase: LoginUseCase
    public let logoutUseCase: LogoutUseCase
    public let registrationUseCase: RegistrationUseCase
    
    public let getCurrentLocationUseCase: GetCurrentLocationUseCase
    
    public let getProfileUseCase: GetProfileUseCase
    public let getProfileIdUseCase: GetProfileIdUseCase
    public let refreshProfileUseCase: RefreshProfileUseCase
    public let updateProfileCounterUseCase: UpdateProfileCounterUseCase
    
    public let handlePushNotificationUseCase: HandlePushNotificationUseCase
    public let registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCase
    
    public let getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase
    
    public let getUserUseCase: GetUserUseCase
    public let refreshUserUseCase: RefreshUserUseCase
    public let updateUserUseCase: UpdateUserUseCase
    
    public let getUsersUseCase: GetUsersUseCase
    public let refreshUsersUseCase: RefreshUsersUseCase
    
    // swiftlint:disable implicitly_unwrapped_optional
    public let getBooksUseCase: GetBooksUseCase!
    public let refreshBooksUseCase: RefreshBooksUseCase!
    // swiftlint:enable implicitly_unwrapped_optional
    
    public init(kmpDependencies: KMPDependency) {
        self.trackAnalyticsEventUseCase = TrackAnalyticsEventUseCaseImpl()
        
        self.loginUseCase = LoginUseCaseImpl()
        self.logoutUseCase = LogoutUseCaseImpl()
        self.registrationUseCase = RegistrationUseCaseImpl()
        
        self.getCurrentLocationUseCase = GetCurrentLocationUseCaseImpl()
        
        self.getProfileUseCase = GetProfileUseCaseImpl()
        self.getProfileIdUseCase = GetProfileIdUseCaseImpl()
        self.refreshProfileUseCase = RefreshProfileUseCaseImpl()
        self.updateProfileCounterUseCase = UpdateProfileCounterUseCaseImpl()
        
        self.handlePushNotificationUseCase = HandlePushNotificationUseCaseImpl()
        self.registerForPushNotificationsUseCase = RegisterForPushNotificationsUseCaseImpl()
        
        self.getRemoteConfigValueUseCase = GetRemoteConfigValueUseCaseImpl()
        
        self.getUserUseCase = GetUserUseCaseImpl()
        self.refreshUserUseCase = RefreshUserUseCaseImpl()
        self.updateUserUseCase = UpdateUserUseCaseImpl()
        
        self.getUsersUseCase = GetUsersUseCaseImpl()
        self.refreshUsersUseCase = RefreshUsersUseCaseImpl()
        
        self.getBooksUseCase = kmpDependencies.getProtocol(GetBooksUseCase.self)
        self.refreshBooksUseCase = kmpDependencies.getProtocol(RefreshBooksUseCase.self)
    }
}
