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

class GetUsersUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(userRepository, .list(.value(.local), page: .any, sortBy: .any, willReturn: .just(User.stubList)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetUsersUseCaseImpl(userRepository: userRepository)
        let output = scheduler.createObserver([User].self)
        
        useCase.execute().bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stubList),
            .completed(0)
        ])
        Verify(userRepository, 1, .list(.value(.local), page: 0, sortBy: "id"))
    }
}
