//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol UpdateUserUseCase: AutoMockable {
    func execute(user: User) -> Observable<Void>
}

public struct UpdateUserUseCaseImpl: UpdateUserUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(user: User) -> Observable<Void> {
        userRepository.updateRx(.remote, user: user).mapToVoid()
    }
}
