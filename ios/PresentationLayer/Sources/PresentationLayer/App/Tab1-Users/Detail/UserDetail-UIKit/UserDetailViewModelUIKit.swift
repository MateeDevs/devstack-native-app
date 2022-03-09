//
//  Created by Petr Chmelar on 28/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import Resolver
import RxCocoa
import RxSwift

final class UserDetailViewModelUIKit: BaseViewModel, ViewModelUIKit {
    
    let input: Input
    let output: Output
    
    struct Input {
        let refreshTrigger: AnyObserver<Void>
    }
    
    struct Output {
        let user: OutputUser
        let isRefreshing: Driver<Bool>
    }

    struct OutputUser {
        let fullName: Driver<String>
        let initials: Driver<String>
        let imageURL: Driver<String?>
    }
    
    convenience init(userId: String) {
        self.init(
            userId: userId,
            getUserUseCase: Resolver.resolve(),
            refreshUserUseCase: Resolver.resolve(),
            trackAnalyticsEventUseCase: Resolver.resolve()
        )
    }
    
    init(
        userId: String,
        getUserUseCase: GetUserUseCase,
        refreshUserUseCase: RefreshUserUseCase,
        trackAnalyticsEventUseCase: TrackAnalyticsEventUseCase
    ) {
        
        // MARK: Setup inputs
        
        let refreshTrigger = PublishSubject<Void>()
        
        self.input = Input(
            refreshTrigger: refreshTrigger.asObserver()
        )

        // MARK: Transformations
        
        let user = getUserUseCase.execute(id: userId).ignoreErrors().share(replay: 1)
        
        let activity = ActivityIndicator()
        
        let refreshUser = refreshTrigger.flatMap { _ -> Observable<Void> in
            refreshUserUseCase.execute(id: userId).trackActivity(activity).ignoreErrors()
        }.share()
        
        let isRefreshing = Observable<Bool>.merge(
            activity.asObservable(),
            refreshUser.map { _ in false }
        )

        // MARK: Setup outputs
        
        self.output = Output(
            user: OutputUser(
                fullName: user.map { $0.fullName }.asDriver(),
                initials: user.map { $0.fullName.initials }.asDriver(),
                imageURL: user.map { $0.pictureUrl }.asDriver()
            ),
            isRefreshing: isRefreshing.asDriver()
        )
        
        super.init(
            trackScreenAppear: { trackAnalyticsEventUseCase.execute(UserEvent.userDetail(id: userId).analyticsEvent) }
        )
    }
}
