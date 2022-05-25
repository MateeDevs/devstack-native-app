//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import UseCaseMocks
import XCTest

class UpdateProfileCounterUseCaseTests: BaseTestCase {
    
    private let updatedUserStub = User(copy: User.stub, counter: User.stub.counter + 1)
    
    // MARK: Dependencies
    
    private let getProfileIdUseCase = GetProfileIdUseCaseMock()
    private let getUserUseCase = GetUserUseCaseMock()
    private let updateUserUseCase = UpdateUserUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(getProfileIdUseCase, .execute(willReturn: AuthToken.stub.userId))
        Given(getUserUseCase, .execute(.any, id: .any, willReturn: User.stub))
    }
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = UpdateProfileCounterUseCaseImpl(
            getProfileIdUseCase: getProfileIdUseCase,
            getUserUseCase: getUserUseCase,
            updateUserUseCase: updateUserUseCase
        )
        
        try await useCase.execute(value: User.stub.counter + 1)
        
        Verify(getProfileIdUseCase, 1, .execute())
        Verify(getUserUseCase, 1, .execute(.value(.local), id: .value(AuthToken.stub.userId)))
        Verify(updateUserUseCase, 1, .execute(.value(.local), user: .value(updatedUserStub)))
    }
}
