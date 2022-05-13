//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DataLayer
import DomainLayer
import DomainStubs
import ProviderMocks
import RxSwift
import SwiftyMocky
import XCTest

class UserRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let newDatabaseProvider = NewDatabaseProviderMock()
    private let databaseProvider = DatabaseProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    private func createRepository() -> UserRepository {
        UserRepositoryImpl(
            newDatabaseProvider: newDatabaseProvider,
            databaseProvider: databaseProvider,
            networkProvider: networkProvider
        )
    }
    
    // MARK: Tests
    
    func testCreateRxValid() {
        let repository = createRepository()
        let output = scheduler.createObserver(User.self)
        
        repository.createRx(.stubValid).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testCreateRxExistingEmail() {
        let repository = createRepository()
        networkProvider.requestReturnError = RepositoryError(statusCode: StatusCode.httpConflict, message: "")
        let output = scheduler.createObserver(User.self)

        repository.createRx(.stubExistingEmail).bind(to: output).disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(output.events, [
            .error(0, RepositoryError(statusCode: StatusCode.httpConflict, message: ""))
        ])
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 0)
    }
    
    func testReadRxLocal() {
        let repository = createRepository()
        databaseProvider.observableObjectReturnValue = User.stub.databaseModel
        let output = scheduler.createObserver(User.self)

        repository.readRx(.local, id: User.stub.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableObjectCallsCount, 1)
        XCTAssertEqual(networkProvider.requestCallsCount, 0)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 0)
    }
    
    func testReadRxRemote() {
        let repository = createRepository()
        let output = scheduler.createObserver(User.self)

        repository.readRx(.remote, id: User.stub.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableObjectCallsCount, 0)
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testListRxLocal() {
        let repository = createRepository()
        databaseProvider.observableCollectionReturnValue = User.stubList.map { $0.databaseModel }
        let output = scheduler.createObserver([User].self)

        repository.readRx(.local, page: 0, sortBy: "id").bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stubList),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableCollectionCallsCount, 1)
        XCTAssertEqual(networkProvider.requestCallsCount, 0)
        XCTAssertEqual(databaseProvider.saveCollectionCallsCount, 0)
    }
    
    func testListRxRemote() {
        let repository = createRepository()
        let output = scheduler.createObserver([User].self)

        repository.readRx(.remote, page: 0, sortBy: "id").bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stubList),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableCollectionCallsCount, 0)
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveCollectionCallsCount, 1)
    }
    
    func testUpdateRxLocal() {
        let repository = createRepository()
        let output = scheduler.createObserver(User.self)

        repository.updateRx(.local, user: .stub).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.requestCallsCount, 0)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testUpdateRxRemote() {
        let repository = createRepository()
        let output = scheduler.createObserver(User.self)

        repository.updateRx(.remote, user: .stub).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
}
