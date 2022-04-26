//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol UpdateProfileCounterUseCase: AutoMockable {
    func execute(value: Int) -> Observable<Void>
}

public struct UpdateProfileCounterUseCaseImpl: UpdateProfileCounterUseCase {
    
    private let authTokenRepository: AuthTokenRepository
    private let userRepository: UserRepository
    
    public init(
        authTokenRepository: AuthTokenRepository,
        userRepository: UserRepository
    ) {
        self.authTokenRepository = authTokenRepository
        self.userRepository = userRepository
    }
    
    public func execute(value: Int) -> Observable<Void> {
        guard let authToken = authTokenRepository.read() else { return .error(CommonError.noAuthToken) }
        return userRepository.readRx(.local, id: authToken.userId).take(1)
            .flatMap { profile -> Observable<User> in
                let updatedProfile = User(copy: profile, counter: profile.counter + value)
                return userRepository.updateRx(.local, user: updatedProfile)
            }.mapToVoid()
    }
}
