//
//  Created by Petr Chmelar on 19/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer
import DomainLayer
import DomainStubs
import ProviderMocks
import SwiftyMocky
import XCTest

class AuthRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let databaseProvider = DatabaseProviderMock()
    private let keychainProvider = KeychainProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(keychainProvider, .read(.value(.authToken), willReturn: AuthToken.stub.token))
        Given(keychainProvider, .read(.value(.userId), willReturn: AuthToken.stub.userId))
    }
    
    private func createRepository() -> AuthRepository {
        AuthRepositoryImpl(
            databaseProvider: databaseProvider,
            keychainProvider: keychainProvider,
            networkProvider: networkProvider
        )
    }
    
    // MARK: Tests
    
    func testLoginValid() async throws {
        let repository = createRepository()
        
        try await repository.login(.stubValid)
        
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        Verify(keychainProvider, 1, .update(.value(.authToken), value: .value(AuthToken.stub.token)))
        Verify(keychainProvider, 1, .update(.value(.userId), value: .value(AuthToken.stub.userId)))
    }
    
    func testLoginInvalidPassword() async throws {
        let repository = createRepository()
        networkProvider.requestReturnError = NetworkProviderError.requestFailed(statusCode: .unathorized, message: "")
        
        do {
            _ = try await repository.login(.stubInvalidPassword)
            XCTFail("Should throw")
        } catch {
            XCTAssertEqual(error as? AuthError, .login(.invalidCredentials))
            XCTAssertEqual(networkProvider.requestCallsCount, 1)
            Verify(keychainProvider, 0, .update(.any, value: .any))
        }
    }
    
    func testRegistrationValid() async throws {
        let repository = createRepository()
         
        try await repository.registration(.stubValid)

        XCTAssertEqual(networkProvider.requestCallsCount, 1)
    }
    
    func testRegistrationExistingEmail() async throws {
        let repository = createRepository()
        networkProvider.requestReturnError = NetworkProviderError.requestFailed(statusCode: .conflict, message: "")
        
        do {
            _ = try await repository.registration(.stubExistingEmail)
            XCTFail("Should throw")
        } catch {
            XCTAssertEqual(error as? AuthError, .registration(.userAlreadyExists))
            XCTAssertEqual(networkProvider.requestCallsCount, 1)
        }
    }
    
    func testReadProfileId() throws {
        let repository = createRepository()
        
        let profileId = try repository.readProfileId()
        
        XCTAssertEqual(profileId, AuthToken.stub.userId)
        Verify(keychainProvider, 1, .read(.value(.userId)))
    }
    
    func testLogout() throws {
        let repository = createRepository()
        
        try repository.logout()
        
        XCTAssertEqual(databaseProvider.deleteAllCallsCount, 1)
        Verify(keychainProvider, 1, .deleteAll())
    }
}
