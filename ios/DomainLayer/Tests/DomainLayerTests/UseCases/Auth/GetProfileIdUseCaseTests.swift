//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import XCTest

class GetProfileIdUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(authRepository, .readProfileId(willReturn: AuthToken.stub.userId))
    }
    
    // MARK: Tests

    func testExecute() throws {
        let useCase = GetProfileIdUseCaseImpl(authRepository: authRepository)
        
        let profileId = try useCase.execute()
        
        XCTAssertEqual(profileId, AuthToken.stub.userId)
        Verify(authRepository, 1, .readProfileId())
    }
}
