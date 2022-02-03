//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasUpdateUserUseCase {
    var updateUserUseCase: UpdateUserUseCase { get }
}

public protocol UpdateUserUseCase: AutoMockable {
    func execute(user: User) -> Observable<Void>
}

public struct UpdateUserUseCaseImpl: UpdateUserUseCase {
    
    @Injected private var userRepository: UserRepository
    
    public func execute(user: User) -> Observable<Void> {
        userRepository.update(.remote, user: user).mapToVoid()
    }
}
