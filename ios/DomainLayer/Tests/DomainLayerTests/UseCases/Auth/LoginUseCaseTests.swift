//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DomainLayer
import DomainStubs
import RepositoryMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class LoginUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(authTokenRepository, .create(.any, willReturn: .just(AuthToken.stub)))
        
        Resolver.register { self.authTokenRepository as AuthTokenRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = LoginUseCaseImpl()
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(.stubValid).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(authTokenRepository, 1, .create(.value(.stubValid)))
    }
}
