//
//  Created by Petr Chmelar on 17.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import protocol DevstackKmpShared.GetBooksUseCase
import protocol DevstackKmpShared.RefreshBooksUseCase
import DomainLayer

public struct UseCaseDependencyMock: UseCaseDependency {
    
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
    
//    public let getBooksUseCase: GetBooksUseCase
//    public let refreshBooksUseCase: RefreshBooksUseCase
    
    public init(
        trackAnalyticsEventUseCase: TrackAnalyticsEventUseCase = TrackAnalyticsEventUseCaseMock(),
        loginUseCase: LoginUseCase = LoginUseCaseMock(),
        logoutUseCase: LogoutUseCase = LogoutUseCaseMock(),
        registrationUseCase: RegistrationUseCase = RegistrationUseCaseMock(),
        getCurrentLocationUseCase: GetCurrentLocationUseCase = GetCurrentLocationUseCaseMock(),
        getProfileUseCase: GetProfileUseCase = GetProfileUseCaseMock(),
        getProfileIdUseCase: GetProfileIdUseCase = GetProfileIdUseCaseMock(),
        refreshProfileUseCase: RefreshProfileUseCase = RefreshProfileUseCaseMock(),
        updateProfileCounterUseCase: UpdateProfileCounterUseCase = UpdateProfileCounterUseCaseMock(),
        handlePushNotificationUseCase: HandlePushNotificationUseCase = HandlePushNotificationUseCaseMock(),
        registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCase = RegisterForPushNotificationsUseCaseMock(),
        getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase = GetRemoteConfigValueUseCaseMock(),
        getUserUseCase: GetUserUseCase = GetUserUseCaseMock(),
        refreshUserUseCase: RefreshUserUseCase = RefreshUserUseCaseMock(),
        updateUserUseCase: UpdateUserUseCase = UpdateUserUseCaseMock(),
        getUsersUseCase: GetUsersUseCase = GetUsersUseCaseMock(),
        refreshUsersUseCase: RefreshUsersUseCase = RefreshUsersUseCaseMock()/*,
        getBooksUseCase: GetBooksUseCase = GetBooksUseCaseMock(),
        refreshBooksUseCase: RefreshBooksUseCase = RefreshBooksUseCaseMock()*/
    ) {
        self.trackAnalyticsEventUseCase = trackAnalyticsEventUseCase
        self.loginUseCase = loginUseCase
        self.logoutUseCase = logoutUseCase
        self.registrationUseCase = registrationUseCase
        self.getCurrentLocationUseCase = getCurrentLocationUseCase
        self.getProfileUseCase = getProfileUseCase
        self.getProfileIdUseCase = getProfileIdUseCase
        self.refreshProfileUseCase = refreshProfileUseCase
        self.updateProfileCounterUseCase = updateProfileCounterUseCase
        self.handlePushNotificationUseCase = handlePushNotificationUseCase
        self.registerForPushNotificationsUseCase = registerForPushNotificationsUseCase
        self.getRemoteConfigValueUseCase = getRemoteConfigValueUseCase
        self.getUserUseCase = getUserUseCase
        self.refreshUserUseCase = refreshUserUseCase
        self.updateUserUseCase = updateUserUseCase
        self.getUsersUseCase = getUsersUseCase
        self.refreshUsersUseCase = refreshUsersUseCase
//        self.getBooksUseCase = getBooksUseCase
//        self.refreshBooksUseCase = refreshBooksUseCase
    }
}
