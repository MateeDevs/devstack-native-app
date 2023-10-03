//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class LoginUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositorySpy()
    private let validateEmailUseCase = ValidateEmailUseCaseSpy()
    private let validatePasswordUseCase = ValidatePasswordUseCaseSpy()
    
    // MARK: Tests
    
    func testExecute() async throws {
        let useCase = LoginUseCaseImpl(
            authRepository: authRepository,
            validateEmailUseCase: validateEmailUseCase,
            validatePasswordUseCase: validatePasswordUseCase
        )
        
        try await useCase.execute(.stubValid)

        XCTAssert(validateEmailUseCase.executeReceivedInvocations == [LoginData.stubValid.email])
        XCTAssert(validatePasswordUseCase.executeReceivedInvocations == [LoginData.stubValid.password])
        XCTAssert(authRepository.loginReceivedInvocations == [.stubValid])
    }
}
