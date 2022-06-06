//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain
import SharedDomainMocks
import XCTest

final class GetProfileIdUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositoryMock()
    
    // MARK: Tests

    func testExecute() throws {
        let useCase = GetProfileIdUseCaseImpl(authRepository: authRepository)
        authRepository.readProfileIdReturnValue = AuthToken.stub.userId
        
        let profileId = try useCase.execute()
        
        XCTAssertEqual(profileId, AuthToken.stub.userId)
        XCTAssertEqual(authRepository.readProfileIdCallsCount, 1)
    }
}
