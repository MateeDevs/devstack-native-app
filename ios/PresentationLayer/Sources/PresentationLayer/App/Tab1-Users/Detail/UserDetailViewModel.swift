//
//  Created by Petr Chmelar on 28/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import RxCocoa
import RxSwift

final class UserDetailViewModel: BaseViewModel, ViewModel {
    
    typealias Dependencies =
        HasGetUserUseCase &
        HasRefreshUserUseCase &
        HasTrackAnalyticsEventUseCase
    
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
    
    init(dependencies: Dependencies, userId: String) {
        
        // MARK: Setup inputs
        
        let refreshTrigger = PublishSubject<Void>()
        
        self.input = Input(
            refreshTrigger: refreshTrigger.asObserver()
        )

        // MARK: Transformations
        
        let user = dependencies.getUserUseCase.execute(id: userId).ignoreErrors().share(replay: 1)
        
        let activity = ActivityIndicator()
        
        let refreshUser = refreshTrigger.flatMap { _ -> Observable<Void> in
            dependencies.refreshUserUseCase.execute(id: userId).trackActivity(activity).ignoreErrors()
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
            trackScreenAppear: { dependencies.trackAnalyticsEventUseCase.execute(UserEvent.userDetail(id: userId).analyticsEvent) }
        )
    }
}
