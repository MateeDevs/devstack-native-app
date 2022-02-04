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

class UpdateProfileCounterUseCaseTests: BaseTestCase {
    
    private let updatedUser = User(copy: User.stub, counter: User.stub.counter + 1)
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    private let userRepository = UserRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(authTokenRepository, .read(willReturn: AuthToken.stub))
        Given(userRepository, .read(.value(.local), id: .value(User.stub.id), willReturn: .just(User.stub)))
        Given(userRepository, .update(.value(.local), user: .value(updatedUser), willReturn: .just(updatedUser)))
        
        Resolver.register { self.authTokenRepository as AuthTokenRepository }
        Resolver.register { self.userRepository as UserRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = UpdateProfileCounterUseCaseImpl()
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(value: User.stub.counter + 1).map { _ in true }.bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(authTokenRepository, 1, .read())
        Verify(userRepository, 1, .read(.value(.local), id: .value(User.stub.id)))
        Verify(userRepository, 1, .update(.value(.local), user: .value(updatedUser)))
    }
}
