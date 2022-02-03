//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasUpdateProfileCounterUseCase {
    var updateProfileCounterUseCase: UpdateProfileCounterUseCase { get }
}

public protocol UpdateProfileCounterUseCase: AutoMockable {
    func execute(value: Int) -> Observable<Void>
}

public struct UpdateProfileCounterUseCaseImpl: UpdateProfileCounterUseCase {
    
    @Injected private var authTokenRepository: AuthTokenRepository
    @Injected private var userRepository: UserRepository
    
    public func execute(value: Int) -> Observable<Void> {
        guard let authToken = authTokenRepository.read() else { return .error(CommonError.noAuthToken) }
        return userRepository.read(.local, id: authToken.userId).take(1)
            .flatMap { profile -> Observable<User> in
                let updatedProfile = User(copy: profile, counter: profile.counter + value)
                return userRepository.update(.local, user: updatedProfile)
            }.mapToVoid()
    }
}
