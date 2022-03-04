//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import Resolver
import RxCocoa
import RxSwift

final class UsersViewModelUIKit: BaseViewModel, ViewModelUIKit {

    let input: Input
    let output: Output
    
    struct Input {
        let page: AnyObserver<Int>
    }
    
    struct Output {
        let users: Driver<[User]>
        let loadedCount: Driver<Int>
        let isRefreshing: Driver<Bool>
    }
    
    convenience init() {
        self.init(
            getUsersUseCase: Resolver.resolve(),
            refreshUsersUseCase: Resolver.resolve()
        )
    }
    
    init(
        getUsersUseCase: GetUsersUseCase,
        refreshUsersUseCase: RefreshUsersUseCase
    ) {
        
        // MARK: Setup inputs
        
        let page = PublishSubject<Int>()
        
        self.input = Input(
            page: page.asObserver()
        )

        // MARK: Transformations
        
        let users = getUsersUseCase.execute().ignoreErrors().share(replay: 1)
        
        let activity = ActivityIndicator()
        
        let refreshUsers = page.flatMap { page -> Observable<Int> in
            refreshUsersUseCase.execute(page: page).trackActivity(activity).ignoreErrors()
        }.share()
        
        let isRefreshing = Observable<Bool>.merge(
            activity.asObservable(),
            refreshUsers.map { _ in false }
        )

        // MARK: Setup outputs
        
        self.output = Output(
            users: users.asDriver(),
            loadedCount: refreshUsers.asDriver(),
            isRefreshing: isRefreshing.asDriver()
        )
        
        super.init()
    }
}
