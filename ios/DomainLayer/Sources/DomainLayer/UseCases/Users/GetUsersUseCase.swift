//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasGetUsersUseCase {
    var getUsersUseCase: GetUsersUseCase { get }
}

public protocol GetUsersUseCase: AutoMockable {
    func execute() -> Observable<[User]>
}

public struct GetUsersUseCaseImpl: GetUsersUseCase {
    
    public typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> Observable<[User]> {
        dependencies.userRepository.list(.local, page: 0, sortBy: "id")
    }
}
