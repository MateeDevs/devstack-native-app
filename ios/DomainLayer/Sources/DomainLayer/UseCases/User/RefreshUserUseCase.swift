//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol RefreshUserUseCase: AutoMockable {
    func execute(id: String) -> Observable<Void>
}

public struct RefreshUserUseCaseImpl: RefreshUserUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(id: String) -> Observable<Void> {
        userRepository.readRx(.remote, id: id).mapToVoid()
    }
}
