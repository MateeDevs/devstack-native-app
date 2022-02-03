//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasGetUsersUseCase {
    var getUsersUseCase: GetUsersUseCase { get }
}

public protocol GetUsersUseCase: AutoMockable {
    func execute() -> Observable<[User]>
}

public struct GetUsersUseCaseImpl: GetUsersUseCase {
    
    @Injected private var userRepository: UserRepository
    
    public func execute() -> Observable<[User]> {
        userRepository.list(.local, page: 0, sortBy: "id")
    }
}
