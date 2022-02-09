//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol RefreshUsersUseCase: AutoMockable {
    func execute(page: Int) -> Observable<Int>
}

public struct RefreshUsersUseCaseImpl: RefreshUsersUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(page: Int) -> Observable<Int> {
        userRepository.list(.remote, page: page, sortBy: nil).map { $0.count }
    }
}
