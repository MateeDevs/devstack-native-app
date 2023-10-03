//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class UpdateProfileCounterUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let getProfileIdUseCase = GetProfileIdUseCaseSpy()
    private let getUserUseCase = GetUserUseCaseSpy()
    private let updateUserUseCase = UpdateUserUseCaseSpy()
    
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
