//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RepositoryMocks
import RxSwift
import SwiftyMocky
import XCTest

class LogoutUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    
    // MARK: Tests

    func testExecute() {
        let useCase = LogoutUseCaseImpl(authTokenRepository: authTokenRepository)
        
        useCase.execute()
        
        Verify(authTokenRepository, 1, .delete())
    }
}
