//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Spyable

@Spyable
public protocol LoginUseCase {
    func execute(_ data: LoginData) async throws
}

public struct LoginUseCaseImpl: LoginUseCase {
    
    private let authRepository: AuthRepository
    private let validateEmailUseCase: ValidateEmailUseCase
    private let validatePasswordUseCase: ValidatePasswordUseCase
    
    public init(
        authRepository: AuthRepository,
        validateEmailUseCase: ValidateEmailUseCase,
        validatePasswordUseCase: ValidatePasswordUseCase
    ) {
        self.authRepository = authRepository
        self.validateEmailUseCase = validateEmailUseCase
        self.validatePasswordUseCase = validatePasswordUseCase
    }
    
    public func execute(_ data: LoginData) async throws {
        try validateEmailUseCase.execute(data.email)
        try validatePasswordUseCase.execute(data.password)
        _ = try await authRepository.login(data)
    }
}
