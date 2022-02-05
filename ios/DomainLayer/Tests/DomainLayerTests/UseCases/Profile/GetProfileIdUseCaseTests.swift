//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import RxSwift
import SwiftyMocky
import XCTest

class GetProfileIdUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(authTokenRepository, .read(willReturn: AuthToken.stub))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetProfileIdUseCaseImpl(authTokenRepository: authTokenRepository)
        
        let output = useCase.execute()
        
        XCTAssertEqual(output, AuthToken.stub.userId)
        Verify(authTokenRepository, 1, .read())
    }
}
