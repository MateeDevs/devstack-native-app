//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain
import SharedDomainMocks
import XCTest

class RegistrationUseCaseTests: XCTestCase {
    
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
        
        XCTAssert(validateEmailUseCase.executeReceivedInvocations == [RegistrationData.stubValid.email])
        XCTAssert(validatePasswordUseCase.executeReceivedInvocations == [RegistrationData.stubValid.password])
        XCTAssert(authRepository.registrationReceivedInvocations == [.stubValid])
    }
}
