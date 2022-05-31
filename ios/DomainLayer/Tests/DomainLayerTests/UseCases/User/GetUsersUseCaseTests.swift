//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import XCTest

class GetUsersUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(userRepository, .read(.any, page: .any, sortBy: .any, willReturn: [User].stub))
    }
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetUsersUseCaseImpl(userRepository: userRepository)
        
        let users = try await useCase.execute(.local, page: 0)
        
        XCTAssertEqual(users, [User].stub)
        Verify(userRepository, 1, .read(.value(.local), page: 0, sortBy: "id"))
    }
}
