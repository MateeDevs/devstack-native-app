//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import UseCaseMocks
import XCTest

class RegistrationUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositoryMock()
    private let validateEmailUseCase = ValidateEmailUseCaseMock()
    private let validatePasswordUseCase = ValidatePasswordUseCaseMock()
    
    // MARK: Tests
    
    func testExecute() async throws {
        let useCase = RegistrationUseCaseImpl(
            authRepository: authRepository,
            validateEmailUseCase: validateEmailUseCase,
            validatePasswordUseCase: validatePasswordUseCase
        )
        
        try await useCase.execute(.stubValid)
        
        Verify(validateEmailUseCase, 1, .execute(.value(RegistrationData.stubValid.email)))
        Verify(validatePasswordUseCase, 1, .execute(.value(RegistrationData.stubValid.password)))
        Verify(authRepository, 1, .registration(.value(.stubValid)))
    }
}
