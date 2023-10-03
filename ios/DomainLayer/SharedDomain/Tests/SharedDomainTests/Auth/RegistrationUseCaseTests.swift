//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class RegistrationUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositorySpy()
    private let validateEmailUseCase = ValidateEmailUseCaseSpy()
    private let validatePasswordUseCase = ValidatePasswordUseCaseSpy()
    
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
