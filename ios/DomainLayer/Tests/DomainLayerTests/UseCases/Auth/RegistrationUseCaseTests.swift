//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DomainLayer
import DomainStubs
import RepositoryMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class RegistrationUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(userRepository, .create(.any, willReturn: .just(User.stub)))
        
        Resolver.register { self.userRepository as UserRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = RegistrationUseCaseImpl()
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(.stubValid).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(userRepository, 1, .create(.value(.stubValid)))
    }
}
