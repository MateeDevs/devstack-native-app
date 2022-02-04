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

class GetUserUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let userRepository = UserRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(userRepository, .read(.value(.local), id: .value(User.stub.id), willReturn: .just(User.stub)))
        
        Resolver.register { self.userRepository as UserRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetUserUseCaseImpl()
        let output = scheduler.createObserver(User.self)
        
        useCase.execute(id: User.stub.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        Verify(userRepository, 1, .read(.value(.local), id: .value(User.stub.id)))
    }
}
