//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasRefreshUserUseCase {
    var refreshUserUseCase: RefreshUserUseCase { get }
}

public protocol RefreshUserUseCase: AutoMockable {
    func execute(id: String) -> Observable<Void>
}

public struct RefreshUserUseCaseImpl: RefreshUserUseCase {
    
    @Injected private var userRepository: UserRepository
    
    public func execute(id: String) -> Observable<Void> {
        userRepository.read(.remote, id: id).mapToVoid()
    }
}
