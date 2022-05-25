//
//  Created by Petr Chmelar on 24.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import UseCaseMocks
import XCTest

class IsUserLoggedUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let getProfileIdUseCase = GetProfileIdUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(getProfileIdUseCase, .execute(willReturn: AuthToken.stub.userId))
    }
    
    // MARK: Tests
    
    func testExecute() {
        let useCase = IsUserLoggedUseCaseImpl(getProfileIdUseCase: getProfileIdUseCase)
        
        let isLogged = useCase.execute()
        
        XCTAssertEqual(isLogged, true)
        Verify(getProfileIdUseCase, 1, .execute())
    }
}
