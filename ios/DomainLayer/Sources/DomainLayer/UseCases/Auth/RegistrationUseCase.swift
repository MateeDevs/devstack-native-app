//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasRegistrationUseCase {
    var registrationUseCase: RegistrationUseCase { get }
}

public protocol RegistrationUseCase: AutoMockable {
    func execute(_ data: RegistrationData) -> Observable<Void>
}

public struct RegistrationUseCaseImpl: RegistrationUseCase {
    
    @Injected private var userRepository: UserRepository
    
    public func execute(_ data: RegistrationData) -> Observable<Void> {
        userRepository.create(data).mapToVoid()
    }
}
