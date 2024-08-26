//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest
import Utilities

final class GetUsersUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositorySpy()
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetUsersUseCaseImpl(userRepository: userRepository)
        userRepository.readPageLimitSortByReturnValue = Pages<User>.stub
        
        let users = try await useCase.execute(.local, page: 0, limit: 100)
        
        XCTAssertEqual(users, Pages<User>.stub)
        XCTAssert(userRepository.readPageLimitSortByReceivedInvocations == [(.local, 0, 100, "id")])
    }
}
