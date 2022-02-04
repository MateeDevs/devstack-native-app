//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol GetUserUseCase: AutoMockable {
    func execute(id: String) -> Observable<User>
}

public struct GetUserUseCaseImpl: GetUserUseCase {
    
    @Injected private var userRepository: UserRepository
    
    public func execute(id: String) -> Observable<User> {
        userRepository.read(.local, id: id)
    }
}
