//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain
import SharedDomainMocks
import XCTest

class UpdateProfileCounterUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let getProfileIdUseCase = GetProfileIdUseCaseMock()
    private let getUserUseCase = GetUserUseCaseMock()
    private let updateUserUseCase = UpdateUserUseCaseMock()
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = UpdateProfileCounterUseCaseImpl(
            getProfileIdUseCase: getProfileIdUseCase,
            getUserUseCase: getUserUseCase,
            updateUserUseCase: updateUserUseCase
        )
        getProfileIdUseCase.executeReturnValue = AuthToken.stub.userId
        getUserUseCase.executeIdReturnValue = User.stub
        
        try await useCase.execute(value: User.stub.counter + 1)
        
        XCTAssertEqual(getProfileIdUseCase.executeCallsCount, 1)
        XCTAssert(getUserUseCase.executeIdReceivedInvocations == [(.local, AuthToken.stub.userId)])
        XCTAssert(updateUserUseCase.executeUserReceivedInvocations == [(.local, User(copy: User.stub, counter: User.stub.counter + 1))])
    }
}
