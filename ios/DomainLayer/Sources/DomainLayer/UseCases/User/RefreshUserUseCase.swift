//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasRefreshUserUseCase {
    var refreshUserUseCase: RefreshUserUseCase { get }
}

public protocol RefreshUserUseCase: AutoMockable {
    func execute(id: String) -> Observable<Void>
}

public struct RefreshUserUseCaseImpl: RefreshUserUseCase {
    
    public typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(id: String) -> Observable<Void> {
        dependencies.userRepository.read(.remote, id: id).mapToVoid()
    }
}
