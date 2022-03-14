//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import RxSwift
import SwiftyMocky
import XCTest

class LoginUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(authTokenRepository, .create(.any, willReturn: AuthToken.stub))
        Given(authTokenRepository, .createRx(.any, willReturn: .just(AuthToken.stub)))
    }
    
    // MARK: Tests
    
    func testExecute() async throws {
        let useCase = LoginUseCaseImpl(authTokenRepository: authTokenRepository)
        
        try await useCase.execute(.stubValid)
        
        Verify(authTokenRepository, 1, .create(.value(.stubValid)))
    }

    func testExecuteRx() {
        let useCase = LoginUseCaseImpl(authTokenRepository: authTokenRepository)
        let output = scheduler.createObserver(Bool.self)
        
        useCase.executeRx(.stubValid).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(authTokenRepository, 1, .createRx(.value(.stubValid)))
    }
}
