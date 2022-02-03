//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasRefreshUsersUseCase {
    var refreshUsersUseCase: RefreshUsersUseCase { get }
}

public protocol RefreshUsersUseCase: AutoMockable {
    func execute(page: Int) -> Observable<Int>
}

public struct RefreshUsersUseCaseImpl: RefreshUsersUseCase {
    
    @Injected private var userRepository: UserRepository
    
    public func execute(page: Int) -> Observable<Int> {
        userRepository.list(.remote, page: page, sortBy: nil).map { $0.count }
    }
}
