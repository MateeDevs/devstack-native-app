//
//  Created by Petr Chmelar on 09/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import CoreLocation
import DomainLayer
import RxCocoa
import RxSwift

final class ProfileViewModel: BaseViewModel, ViewModel {
    
    typealias Dependencies =
        HasGetProfileUseCase &
        HasRefreshProfileUseCase &
        HasLogoutUseCase &
        HasGetCurrentLocationUseCase &
        HasGetRemoteConfigValueUseCase &
        HasRegisterForPushNotificationsUseCase
    
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
    
    init(dependencies: Dependencies) {
        
        // MARK: Setup inputs

        let registerPushNotificationsButtonTaps = PublishSubject<Void>()
        let logoutButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            registerPushNotificationsButtonTaps: registerPushNotificationsButtonTaps.asObserver(),
            logoutButtonTaps: logoutButtonTaps.asObserver()
        )
        
        // MARK: Transformations
        
        let activity = ActivityIndicator()

        let profile = dependencies.getProfileUseCase.execute().ignoreErrors().share(replay: 1)
        let refreshProfile = dependencies.refreshProfileUseCase.execute().trackActivity(activity).ignoreErrors().share()
        
        let isRefreshing = Observable<Bool>.merge(
            activity.asObservable(),
            refreshProfile.map { _ in false }
        )
        
        let currentLocation = dependencies.getCurrentLocationUseCase.execute().ignoreErrors().take(1)
        
        let remoteConfigLabelIsHidden = dependencies.getRemoteConfigValueUseCase
            .execute(.profileLabelIsVisible).ignoreErrors().map { !$0 }
        
        let registerForPushNotifications = registerPushNotificationsButtonTaps.flatMapLatest { _ -> Observable<Void> in
            dependencies.registerForPushNotificationsUseCase.execute(
                options: [.alert, .badge, .sound],
                completionHandler: { _, _ in }
            )
            return .just(())
        }.share()

        let logout = logoutButtonTaps.flatMapLatest { _ -> Observable<Void> in
            dependencies.logoutUseCase.execute()
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
