//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import RxSwift
import SwiftyMocky
import XCTest

class RegistrationUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(userRepository, .createRx(.any, willReturn: .just(User.stub)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = RegistrationUseCaseImpl(userRepository: userRepository)
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(.stubValid).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(userRepository, 1, .createRx(.value(.stubValid)))
    }
}
