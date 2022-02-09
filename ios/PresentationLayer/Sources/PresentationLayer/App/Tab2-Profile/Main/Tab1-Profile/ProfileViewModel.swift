//
//  Created by Petr Chmelar on 09/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import CoreLocation
import DomainLayer
import Resolver
import RxCocoa
import RxSwift

final class ProfileViewModel: BaseViewModel, ViewModel {
    
    let input: Input
    let output: Output
    
    struct Input {
        let registerPushNotificationsButtonTaps: AnyObserver<Void>
        let logoutButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let profile: OutputProfile
        let isRefreshing: Driver<Bool>
        let currentLocation: Driver<String>
        let remoteConfigLabelIsHidden: Driver<Bool>
        let registerForPushNotifications: Driver<Void>
        let flow: Driver<Flow.Profile>
    }

    struct OutputProfile {
        let fullName: Driver<String>
        let initials: Driver<String>
        let imageURL: Driver<String?>
    }
    
    convenience init() {
        self.init(
            getProfileUseCase: Resolver.resolve(),
            refreshProfileUseCase: Resolver.resolve(),
            logoutUseCase: Resolver.resolve(),
            getCurrentLocationUseCase: Resolver.resolve(),
            getRemoteConfigValueUseCase: Resolver.resolve(),
            registerForPushNotificationsUseCase: Resolver.resolve()
        )
    }
    
    init(
        getProfileUseCase: GetProfileUseCase,
        refreshProfileUseCase: RefreshProfileUseCase,
        logoutUseCase: LogoutUseCase,
        getCurrentLocationUseCase: GetCurrentLocationUseCase,
        getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase,
        registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCase
    ) {
        
        // MARK: Setup inputs

        let registerPushNotificationsButtonTaps = PublishSubject<Void>()
        let logoutButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            registerPushNotificationsButtonTaps: registerPushNotificationsButtonTaps.asObserver(),
            logoutButtonTaps: logoutButtonTaps.asObserver()
        )
        
        // MARK: Transformations
        
        let activity = ActivityIndicator()

        let profile = getProfileUseCase.execute().ignoreErrors().share(replay: 1)
        let refreshProfile = refreshProfileUseCase.execute().trackActivity(activity).ignoreErrors().share()
        
        let isRefreshing = Observable<Bool>.merge(
            activity.asObservable(),
            refreshProfile.map { _ in false }
        )
        
        let currentLocation = getCurrentLocationUseCase.execute().ignoreErrors().take(1)
        
        let remoteConfigLabelIsHidden = getRemoteConfigValueUseCase
            .execute(.profileLabelIsVisible).ignoreErrors().map { !$0 }
        
        let registerForPushNotifications = registerPushNotificationsButtonTaps.flatMapLatest { _ -> Observable<Void> in
            registerForPushNotificationsUseCase.execute(
                options: [.alert, .badge, .sound],
                completionHandler: { _, _ in }
            )
            return .just(())
        }.share()

        let logout = logoutButtonTaps.flatMapLatest { _ -> Observable<Void> in
            logoutUseCase.execute()
            return .just(())
        }.share()

        // MARK: Setup outputs
        
        self.output = Output(
            profile: OutputProfile(
                fullName: profile.map { $0.fullName }.asDriver(),
                initials: profile.map { $0.fullName.initials }.asDriver(),
                imageURL: profile.map { $0.pictureUrl }.asDriver()
            ),
            isRefreshing: isRefreshing.asDriver(),
            currentLocation: currentLocation.map { $0.coordinate.toString() }.asDriver(),
            remoteConfigLabelIsHidden: remoteConfigLabelIsHidden.asDriver(),
            registerForPushNotifications: registerForPushNotifications.asDriver(),
            flow: logout.map { .presentOnboarding }.asDriver()
        )
        
        super.init()
    }
}
