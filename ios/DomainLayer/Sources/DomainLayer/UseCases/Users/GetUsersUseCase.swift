//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol GetUsersUseCase: AutoMockable {
    func execute() -> Observable<[User]>
}

public struct GetUsersUseCaseImpl: GetUsersUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute() -> Observable<[User]> {
        userRepository.list(.local, page: 0, sortBy: "id")
    }
}
