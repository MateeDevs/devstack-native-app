//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DomainLayer
import DomainStubs
import RepositoryMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class UpdateUserUseCaseTests: BaseTestCase {
    
    private let updatedUser = User(copy: User.stub, bio: "Updated user")
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(userRepository, .update(.value(.remote), user: .value(updatedUser), willReturn: .just(updatedUser)))
        
        Resolver.register { self.userRepository as UserRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = UpdateUserUseCaseImpl()
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(user: updatedUser).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(userRepository, 1, .update(.value(.remote), user: .value(updatedUser)))
    }
}
