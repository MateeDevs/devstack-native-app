//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol GetProfileIdUseCase: AutoMockable {
    func execute() throws -> String
}

public struct GetProfileIdUseCaseImpl: GetProfileIdUseCase {
    
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func execute() throws -> String {
        try authRepository.readProfileId()
    }
}
