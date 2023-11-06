//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import SharedDomainMocks
import XCTest

final class UpdateUserUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositorySpy()
    
    // MARK: Tests

    func testExecute() async throws {
        let updatedUser = User(copy: User.stub, bio: "Updated user")
        let useCase = UpdateUserUseCaseImpl(userRepository: userRepository)
        userRepository.updateUserReturnValue = updatedUser
        
        try await useCase.execute(.local, user: updatedUser)
        
        XCTAssert(userRepository.updateUserReceivedInvocations == [(.local, updatedUser)])
    }
}
