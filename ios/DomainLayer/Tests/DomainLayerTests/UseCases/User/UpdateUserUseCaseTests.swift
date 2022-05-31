//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import XCTest

class UpdateUserUseCaseTests: BaseTestCase {
    
    private let updatedUserStub = User(copy: User.stub, bio: "Updated user")
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(userRepository, .update(.any, user: .any, willReturn: updatedUserStub))
    }
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = UpdateUserUseCaseImpl(userRepository: userRepository)
        
        try await useCase.execute(.local, user: updatedUserStub)
        
        Verify(userRepository, 1, .update(.value(.local), user: .value(updatedUserStub)))
    }
}
