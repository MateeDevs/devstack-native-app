//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain
import SharedDomainMocks
import XCTest

class GetProfileUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let getProfileIdUseCase = GetProfileIdUseCaseMock()
    private let getUserUseCase = GetUserUseCaseMock()
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetProfileUseCaseImpl(
            getProfileIdUseCase: getProfileIdUseCase,
            getUserUseCase: getUserUseCase
        )
        getProfileIdUseCase.executeReturnValue = AuthToken.stub.userId
        getUserUseCase.executeIdReturnValue = User.stub
        
        let profile = try await useCase.execute(.local)
        
        XCTAssertEqual(profile, User.stub)
        XCTAssertEqual(getProfileIdUseCase.executeCallsCount, 1)
        XCTAssert(getUserUseCase.executeIdReceivedInvocations == [(.local, AuthToken.stub.userId)])
    }
}
