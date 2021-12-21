//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasRegistrationUseCase {
    var registrationUseCase: RegistrationUseCase { get }
}

public protocol RegistrationUseCase: AutoMockable {
    func execute(_ data: RegistrationData) -> Observable<Void>
}

public struct RegistrationUseCaseImpl: RegistrationUseCase {
    
    public typealias Dependencies = HasUserRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(_ data: RegistrationData) -> Observable<Void> {
        dependencies.userRepository.create(data).mapToVoid()
    }
}
