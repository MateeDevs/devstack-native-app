//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

@testable import DataLayer
import DomainLayer
import DomainStubs
import ProviderMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class AuthTokenRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let databaseProvider = DatabaseProviderMock()
    private let keychainProvider = KeychainProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(keychainProvider, .get(.value(.authToken), willReturn: AuthToken.stub.token))
        Given(keychainProvider, .get(.value(.userId), willReturn: AuthToken.stub.userId))
        
        Resolver.register { self.databaseProvider as DatabaseProvider }
        Resolver.register { self.keychainProvider as KeychainProvider }
        Resolver.register { self.networkProvider as NetworkProvider }
    }
    
    // MARK: Tests
    
    func testCreateValid() {
        let repository = AuthTokenRepositoryImpl()
        let output = scheduler.createObserver(AuthToken.self)
        
        repository.create(.stubValid).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, AuthToken.stub),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        Verify(keychainProvider, 1, .save(.value(.authToken), value: .value(AuthToken.stub.token)))
        Verify(keychainProvider, 1, .save(.value(.userId), value: .value(AuthToken.stub.userId)))
    }
    
    func testCreateInvalidPassword() {
        let repository = AuthTokenRepositoryImpl()
        networkProvider.observableRequestReturnError = RepositoryError(statusCode: StatusCode.httpUnathorized, message: "")
        let output = scheduler.createObserver(AuthToken.self)
        
        repository.create(.stubInvalidPassword).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .error(0, RepositoryError(statusCode: StatusCode.httpUnathorized, message: ""))
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        Verify(keychainProvider, 0, .save(.any, value: .any))
    }
    
    func testRead() {
        let repository = AuthTokenRepositoryImpl()
        
        let output = repository.read()
        
        XCTAssertEqual(output, AuthToken.stub)
        Verify(keychainProvider, 1, .get(.value(.userId)))
        Verify(keychainProvider, 1, .get(.value(.authToken)))
    }
    
    func testDelete() {
        let repository = AuthTokenRepositoryImpl()
        
        repository.delete()
        
        XCTAssertEqual(databaseProvider.deleteAllCallsCount, 1)
        Verify(keychainProvider, 1, .deleteAll())
    }
}
