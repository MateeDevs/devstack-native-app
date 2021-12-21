//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasRefreshProfileUseCase {
    var refreshProfileUseCase: RefreshProfileUseCase { get }
}

public protocol RefreshProfileUseCase: AutoMockable {
    func execute() -> Observable<Void>
}

public struct RefreshProfileUseCaseImpl: RefreshProfileUseCase {
    
    public typealias Dependencies =
        HasAuthTokenRepository &
        HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> Observable<Void> {
        guard let authToken = dependencies.authTokenRepository.read() else { return .error(CommonError.noAuthToken) }
        return dependencies.userRepository.read(.remote, id: authToken.userId).mapToVoid()
    }
}
