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

class RefreshProfileUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    private let userRepository = UserRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(authTokenRepository, .read(willReturn: AuthToken.stub))
        Given(userRepository, .read(.value(.remote), id: .value(User.stub.id), willReturn: .just(User.stub)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = RefreshProfileUseCaseImpl(
            authTokenRepository: authTokenRepository,
            userRepository: userRepository
        )
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute().map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(authTokenRepository, 1, .read())
        Verify(userRepository, 1, .read(.value(.remote), id: .value(User.stub.id)))
    }
}
