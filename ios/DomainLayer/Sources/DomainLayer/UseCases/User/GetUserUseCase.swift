//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasGetUserUseCase {
    var getUserUseCase: GetUserUseCase { get }
}

public protocol GetUserUseCase: AutoMockable {
    func execute(id: String) -> Observable<User>
}

public struct GetUserUseCaseImpl: GetUserUseCase {
    
    public typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(id: String) -> Observable<User> {
        dependencies.userRepository.read(.local, id: id)
    }
}
