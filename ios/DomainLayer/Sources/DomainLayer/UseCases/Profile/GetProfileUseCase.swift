//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasGetProfileUseCase {
    var getProfileUseCase: GetProfileUseCase { get }
}

public protocol GetProfileUseCase: AutoMockable {
    func execute() -> Observable<User>
}

public struct GetProfileUseCaseImpl: GetProfileUseCase {
    
    @Injected private var authTokenRepository: AuthTokenRepository
    @Injected private var userRepository: UserRepository
    
    public func execute() -> Observable<User> {
        guard let authToken = authTokenRepository.read() else { return .error(CommonError.noAuthToken) }
        return userRepository.read(.local, id: authToken.userId)
    }
}
