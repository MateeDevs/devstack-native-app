//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import UseCaseMocks
import XCTest

class LoginUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositoryMock()
    private let validateEmailUseCase = ValidateEmailUseCaseMock()
    private let validatePasswordUseCase = ValidatePasswordUseCaseMock()
    
    // MARK: Tests
    
    func testExecute() async throws {
        let useCase = LoginUseCaseImpl(
            authRepository: authRepository,
            validateEmailUseCase: validateEmailUseCase,
            validatePasswordUseCase: validatePasswordUseCase
        )
        
        try await useCase.execute(.stubValid)
        
        Verify(validateEmailUseCase, 1, .execute(.value(LoginData.stubValid.email)))
        Verify(validatePasswordUseCase, 1, .execute(.value(LoginData.stubValid.password)))
        Verify(authRepository, 1, .login(.value(.stubValid)))
    }
}
