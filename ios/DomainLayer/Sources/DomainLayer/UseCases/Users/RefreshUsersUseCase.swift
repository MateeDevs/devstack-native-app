//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasRefreshUsersUseCase {
    var refreshUsersUseCase: RefreshUsersUseCase { get }
}

public protocol RefreshUsersUseCase: AutoMockable {
    func execute(page: Int) -> Observable<Int>
}

public struct RefreshUsersUseCaseImpl: RefreshUsersUseCase {
    
    public typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(page: Int) -> Observable<Int> {
        dependencies.userRepository.list(.remote, page: page, sortBy: nil).map { $0.count }
    }
}
