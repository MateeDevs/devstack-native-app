//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer
import DomainLayer
import DomainStubs
import ProviderMocks
import RxSwift
import SwiftyMocky
import XCTest

class AuthTokenRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let databaseProvider = DatabaseProviderMock()
    private let keychainProvider = KeychainProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(keychainProvider, .read(.value(.authToken), willReturn: AuthToken.stub.token))
        Given(keychainProvider, .read(.value(.userId), willReturn: AuthToken.stub.userId))
    }
    
    private func createRepository() -> AuthTokenRepository {
        AuthTokenRepositoryImpl(
            databaseProvider: databaseProvider,
            keychainProvider: keychainProvider,
            networkProvider: networkProvider
        )
    }
    
    // MARK: Tests
    
    func testCreateValid() async throws {
        let repository = createRepository()
        
        let authToken = try await repository.create(.stubValid)
        
        XCTAssertEqual(authToken, AuthToken.stub)
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        Verify(keychainProvider, 1, .update(.value(.authToken), value: .value(AuthToken.stub.token)))
        Verify(keychainProvider, 1, .update(.value(.userId), value: .value(AuthToken.stub.userId)))
    }
    
    func testCreateRxValid() {
        let repository = createRepository()
        let output = scheduler.createObserver(AuthToken.self)
        
        repository.createRx(.stubValid).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, AuthToken.stub),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        Verify(keychainProvider, 1, .update(.value(.authToken), value: .value(AuthToken.stub.token)))
        Verify(keychainProvider, 1, .update(.value(.userId), value: .value(AuthToken.stub.userId)))
    }
    
    func testCreateInvalidPassword() async throws {
        let repository = createRepository()
        networkProvider.requestReturnError = RepositoryError(statusCode: StatusCode.httpUnathorized, message: "")
        
        do {
            _ = try await repository.create(.stubInvalidPassword)
            XCTFail("Should throw")
        } catch {
            XCTAssertEqual(error as? RepositoryError, RepositoryError(statusCode: StatusCode.httpUnathorized, message: ""))
            XCTAssertEqual(networkProvider.requestCallsCount, 1)
            Verify(keychainProvider, 0, .update(.any, value: .any))
        }
    }
    
    func testCreateRxInvalidPassword() {
        let repository = createRepository()
        networkProvider.requestReturnError = RepositoryError(statusCode: StatusCode.httpUnathorized, message: "")
        let output = scheduler.createObserver(AuthToken.self)
        
        repository.createRx(.stubInvalidPassword).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .error(0, RepositoryError(statusCode: StatusCode.httpUnathorized, message: ""))
        ])
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        Verify(keychainProvider, 0, .update(.any, value: .any))
    }
    
    func testRead() {
        let repository = createRepository()
        
        let output = repository.read()
        
        XCTAssertEqual(output, AuthToken.stub)
        Verify(keychainProvider, 1, .read(.value(.userId)))
        Verify(keychainProvider, 1, .read(.value(.authToken)))
    }
    
    func testDelete() {
        let repository = createRepository()
        
        repository.delete()
        
        XCTAssertEqual(databaseProvider.deleteAllCallsCount, 1)
        Verify(keychainProvider, 1, .deleteAll())
    }
}
