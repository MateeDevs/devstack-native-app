//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasRefreshProfileUseCase {
    var refreshProfileUseCase: RefreshProfileUseCase { get }
}

public protocol RefreshProfileUseCase: AutoMockable {
    func execute() -> Observable<Void>
}

public struct RefreshProfileUseCaseImpl: RefreshProfileUseCase {
    
    @Injected private var authTokenRepository: AuthTokenRepository
    @Injected private var userRepository: UserRepository
    
    public func execute() -> Observable<Void> {
        guard let authToken = authTokenRepository.read() else { return .error(CommonError.noAuthToken) }
        return userRepository.read(.remote, id: authToken.userId).mapToVoid()
    }
}
