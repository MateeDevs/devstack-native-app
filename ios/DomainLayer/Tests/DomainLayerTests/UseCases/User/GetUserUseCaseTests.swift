//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import XCTest

class GetUserUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(userRepository, .read(.any, id: .any, willReturn: User.stub))
    }
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetUserUseCaseImpl(userRepository: userRepository)
        
        let user = try await useCase.execute(.local, id: User.stub.id)
        
        XCTAssertEqual(user, User.stub)
        Verify(userRepository, 1, .read(.value(.local), id: .value(User.stub.id)))
    }
}
