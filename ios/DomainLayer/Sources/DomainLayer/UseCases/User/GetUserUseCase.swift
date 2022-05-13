//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol GetUserUseCase: AutoMockable {
    func execute(id: String) -> Observable<User>
}

public struct GetUserUseCaseImpl: GetUserUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(id: String) -> Observable<User> {
        userRepository.readRx(.local, id: id)
    }
}
