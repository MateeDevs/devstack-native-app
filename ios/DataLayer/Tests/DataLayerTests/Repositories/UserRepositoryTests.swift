//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DataLayer
import DomainLayer
import DomainStubs
import ProviderMocks
import SwiftyMocky
import XCTest

class UserRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private var databaseProvider = DatabaseProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    private func createRepository() -> UserRepository {
        UserRepositoryImpl(
            databaseProvider: databaseProvider,
            networkProvider: networkProvider
        )
    }
    
    // MARK: Tests
    
    func testCreateValid() async throws {
        let repository = createRepository()
        databaseProvider.updateObjectReturnValue = User.stub.databaseModel
         
        let user = try await repository.create(.stubValid)

        XCTAssertEqual(user, User.stub)
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssertEqual(databaseProvider.updateObjectCallsCount, 1)
    }
    
    func testCreateExistingEmail() async throws {
        let repository = createRepository()
        networkProvider.requestReturnError = NetworkProviderError.requestFailed(statusCode: .conflict, message: "")
        
        do {
            _ = try await repository.create(.stubExistingEmail)
            
            XCTFail("Should throw")
        } catch {
            XCTAssertEqual(error as? AuthError.Registration, .userAlreadyExists)
            XCTAssertEqual(networkProvider.requestCallsCount, 1)
            XCTAssertEqual(databaseProvider.updateObjectCallsCount, 0)
        }
    }
    
    func testReadObjectLocal() async throws {
        let repository = createRepository()
        databaseProvider.readObjectReturnValue = User.stub.databaseModel
        
        let user = try await repository.read(.local, id: User.stub.id)
        
        XCTAssertEqual(user, User.stub)
        XCTAssertEqual(networkProvider.requestCallsCount, 0)
        XCTAssertEqual(databaseProvider.readObjectCallsCount, 1)
    }
    
    func testReadObjectRemote() async throws {
        let repository = createRepository()
        databaseProvider.updateObjectReturnValue = User.stub.databaseModel
        
        let user = try await repository.read(.remote, id: User.stub.id)
        
        XCTAssertEqual(user, User.stub)
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssertEqual(databaseProvider.updateObjectCallsCount, 1)
    }
    
    func testReadCollectionLocal() async throws {
        let repository = createRepository()
        databaseProvider.readCollectionReturnValue = User.stubList.map { $0.databaseModel }
        
        let users = try await repository.read(.local, page: 0, sortBy: nil)
        
        XCTAssertEqual(users, User.stubList)
        XCTAssertEqual(networkProvider.requestCallsCount, 0)
        XCTAssertEqual(databaseProvider.readCollectionCallsCount, 1)
    }
    
    func testReadCollectionRemote() async throws {
        let repository = createRepository()
        databaseProvider.updateCollectionReturnValue = User.stubList.map { $0.databaseModel }
        
        let users = try await repository.read(.remote, page: 0, sortBy: nil)
        
        XCTAssertEqual(users, User.stubList)
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssertEqual(databaseProvider.updateCollectionCallsCount, 1)
    }
    
    func testUpdateObjectLocal() async throws {
        let repository = createRepository()
        databaseProvider.updateObjectReturnValue = User.stub.databaseModel
        
        let user = try await repository.update(.local, user: User.stub)
        
        XCTAssertEqual(user, User.stub)
        XCTAssertEqual(networkProvider.requestCallsCount, 0)
        XCTAssertEqual(databaseProvider.updateObjectCallsCount, 1)
    }
    
    func testUpdateObjectRemote() async throws {
        let repository = createRepository()
        databaseProvider.updateObjectReturnValue = User.stub.databaseModel
        
        let user = try await repository.update(.remote, user: User.stub)
        
        XCTAssertEqual(user, User.stub)
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssertEqual(databaseProvider.updateObjectCallsCount, 1)
    }
}
