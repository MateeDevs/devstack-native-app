//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain
import SharedDomainMocks
import XCTest

class LogoutUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositoryMock()
    
    // MARK: Tests

    func testExecute() throws {
        let useCase = LogoutUseCaseImpl(authRepository: authRepository)
        
        try useCase.execute()
        
        XCTAssertEqual(authRepository.logoutCallsCount, 1)
    }
}
