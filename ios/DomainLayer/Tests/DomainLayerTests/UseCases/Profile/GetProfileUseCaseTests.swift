//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import UseCaseMocks
import XCTest

class GetProfileUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let getProfileIdUseCase = GetProfileIdUseCaseMock()
    private let getUserUseCase = GetUserUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(getProfileIdUseCase, .execute(willReturn: AuthToken.stub.userId))
        Given(getUserUseCase, .execute(.any, id: .any, willReturn: User.stub))
    }
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetProfileUseCaseImpl(
            getProfileIdUseCase: getProfileIdUseCase,
            getUserUseCase: getUserUseCase
        )
        
        let profile = try await useCase.execute(.local)
        
        XCTAssertEqual(profile, User.stub)
        Verify(getProfileIdUseCase, 1, .execute())
        Verify(getUserUseCase, 1, .execute(.value(.local), id: .value(AuthToken.stub.userId)))
    }
}
