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

class RefreshUserUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        Given(userRepository, .read(.value(.remote), id: .value(User.stub.id), willReturn: .just(User.stub)))
        return RepositoryDependencyMock(userRepository: userRepository)
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = RefreshUserUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(id: User.stub.id).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(userRepository, 1, .read(.value(.remote), id: .value(User.stub.id)))
    }
}
