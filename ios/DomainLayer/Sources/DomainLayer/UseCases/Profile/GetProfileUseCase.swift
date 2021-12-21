//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasGetProfileUseCase {
    var getProfileUseCase: GetProfileUseCase { get }
}

public protocol GetProfileUseCase: AutoMockable {
    func execute() -> Observable<User>
}

public struct GetProfileUseCaseImpl: GetProfileUseCase {
    
    public typealias Dependencies =
        HasAuthTokenRepository &
        HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> Observable<User> {
        guard let authToken = dependencies.authTokenRepository.read() else { return .error(CommonError.noAuthToken) }
        return dependencies.userRepository.read(.local, id: authToken.userId)
    }
}
