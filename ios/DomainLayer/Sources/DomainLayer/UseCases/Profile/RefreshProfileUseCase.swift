//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol RefreshProfileUseCase: AutoMockable {
    func execute() -> Observable<Void>
}

public struct RefreshProfileUseCaseImpl: RefreshProfileUseCase {
    
    private let authTokenRepository: AuthTokenRepository
    private let userRepository: UserRepository
    
    public init(
        authTokenRepository: AuthTokenRepository,
        userRepository: UserRepository
    ) {
        self.authTokenRepository = authTokenRepository
        self.userRepository = userRepository
    }
    
    public func execute() -> Observable<Void> {
        guard let authToken = authTokenRepository.read() else { return .error(CommonError.noAuthToken) }
        return userRepository.read(.remote, id: authToken.userId).mapToVoid()
    }
}
