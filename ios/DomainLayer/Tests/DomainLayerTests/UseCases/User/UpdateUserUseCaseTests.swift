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

class UpdateUserUseCaseTests: BaseTestCase {
    
    private let updatedUser = User(copy: User.stub, bio: "Updated user")
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(userRepository, .updateRx(.value(.remote), user: .value(updatedUser), willReturn: .just(updatedUser)))
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = UpdateUserUseCaseImpl(userRepository: userRepository)
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(user: updatedUser).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(userRepository, 1, .updateRx(.value(.remote), user: .value(updatedUser)))
    }
}
