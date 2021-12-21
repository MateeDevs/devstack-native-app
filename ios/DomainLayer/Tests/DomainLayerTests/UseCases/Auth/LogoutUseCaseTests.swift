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
    
    private func setupDependencies() -> RepositoryDependency {
        RepositoryDependencyMock(authTokenRepository: authTokenRepository)
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = LogoutUseCaseImpl(dependencies: setupDependencies())
        
        useCase.execute()
        
        Verify(authTokenRepository, 1, .delete())
    }
}
