//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain
import SharedDomainMocks
import XCTest

class GetUserUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetUserUseCaseImpl(userRepository: userRepository)
        userRepository.readIdReturnValue = User.stub
        
        let user = try await useCase.execute(.local, id: User.stub.id)
        
        XCTAssertEqual(user, User.stub)
        XCTAssert(userRepository.readIdReceivedInvocations == [(.local, User.stub.id)])
    }
}
