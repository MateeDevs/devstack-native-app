//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RepositoryMocks
import SwiftyMocky
import XCTest

class LogoutUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositoryMock()
    
    // MARK: Tests

    func testExecute() throws {
        let useCase = LogoutUseCaseImpl(authRepository: authRepository)
        
        try useCase.execute()
        
        Verify(authRepository, 1, .logout())
    }
}
