//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import RxSwift
import SwiftyMocky
import XCTest

class GetProfileUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        Given(authTokenRepository, .read(willReturn: AuthToken.stub))
        Given(userRepository, .read(.value(.local), id: .value(User.stub.id), willReturn: .just(User.stub)))
        
        return RepositoryDependencyMock(
            authTokenRepository: authTokenRepository,
            userRepository: userRepository
        )
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetProfileUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(User.self)
        
        useCase.execute().bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        Verify(authTokenRepository, 1, .read())
        Verify(userRepository, 1, .read(.value(.local), id: .value(User.stub.id)))
    }
}
