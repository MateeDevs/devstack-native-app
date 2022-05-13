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

class RefreshUsersUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(userRepository, .readRx(.value(.remote), page: .any, sortBy: .any, willReturn: .just(User.stubList)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = RefreshUsersUseCaseImpl(userRepository: userRepository)
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(page: 0).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(userRepository, 1, .readRx(.value(.remote), page: 0, sortBy: nil))
    }
}
