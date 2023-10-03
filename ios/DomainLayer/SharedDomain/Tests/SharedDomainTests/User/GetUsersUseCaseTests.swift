//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class GetUsersUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositorySpy()
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetUsersUseCaseImpl(userRepository: userRepository)
        userRepository.readPageSortByReturnValue = [User].stub
        
        let users = try await useCase.execute(.local, page: 0)
        
        XCTAssertEqual(users, [User].stub)
        XCTAssert(userRepository.readPageSortByReceivedInvocations == [(.local, 0, "id")])
    }
}
