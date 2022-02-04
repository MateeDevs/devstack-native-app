//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

// swiftlint:disable file_length

@testable import DataLayer
import DomainLayer
import DomainStubs
import ProviderMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class UserRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let databaseProvider = DatabaseProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Resolver.register { self.databaseProvider as DatabaseProvider }
        Resolver.register { self.networkProvider as NetworkProvider }
    }
    
    // MARK: Tests
    
    func testCreateValid() {
        let repository = UserRepositoryImpl()
        let output = scheduler.createObserver(User.self)
        
        repository.create(.stubValid).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testCreateExistingEmail() {
        let repository = UserRepositoryImpl()
        networkProvider.observableRequestReturnError = RepositoryError(statusCode: StatusCode.httpConflict, message: "")
        let output = scheduler.createObserver(User.self)

        repository.create(.stubExistingEmail).bind(to: output).disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(output.events, [
            .error(0, RepositoryError(statusCode: StatusCode.httpConflict, message: ""))
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 0)
    }
    
    func testReadLocal() {
        let repository = UserRepositoryImpl()
        databaseProvider.observableObjectReturnValue = User.stub.databaseModel
        let output = scheduler.createObserver(User.self)

        repository.read(.local, id: User.stub.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableObjectCallsCount, 1)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 0)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 0)
    }
    
    func testReadRemote() {
        let repository = UserRepositoryImpl()
        let output = scheduler.createObserver(User.self)

        repository.read(.remote, id: User.stub.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableObjectCallsCount, 0)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testReadBoth() {
        let repository = UserRepositoryImpl()
        databaseProvider.observableObjectReturnValue = User.stub.databaseModel
        let output = scheduler.createObserver(User.self)

        repository.read(.both, id: User.stub.id).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableObjectCallsCount, 1)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testListLocal() {
        let repository = UserRepositoryImpl()
        databaseProvider.observableCollectionReturnValue = User.stubList.map { $0.databaseModel }
        let output = scheduler.createObserver([User].self)

        repository.list(.local, page: 0, sortBy: "id").bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stubList),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableCollectionCallsCount, 1)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 0)
        XCTAssertEqual(databaseProvider.saveCollectionCallsCount, 0)
    }
    
    func testListRemote() {
        let repository = UserRepositoryImpl()
        let output = scheduler.createObserver([User].self)

        repository.list(.remote, page: 0, sortBy: "id").bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stubList),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableCollectionCallsCount, 0)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveCollectionCallsCount, 1)
    }

    func testListBoth() {
        let repository = UserRepositoryImpl()
        databaseProvider.observableCollectionReturnValue = User.stubList.map { $0.databaseModel }
        let output = scheduler.createObserver([User].self)

        repository.list(.both, page: 0, sortBy: "id").bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stubList),
            .completed(0)
        ])
        XCTAssertEqual(databaseProvider.observableCollectionCallsCount, 1)
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveCollectionCallsCount, 1)
    }
    
    func testUpdateLocal() {
        let repository = UserRepositoryImpl()
        let output = scheduler.createObserver(User.self)

        repository.update(.local, user: .stub).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 0)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testUpdateRemote() {
        let repository = UserRepositoryImpl()
        let output = scheduler.createObserver(User.self)

        repository.update(.remote, user: .stub).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 1)
    }
    
    func testUpdateBoth() {
        let repository = UserRepositoryImpl()
        let output = scheduler.createObserver(User.self)

        repository.update(.both, user: .stub).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, User.stub),
            .completed(0)
        ])
        XCTAssertEqual(networkProvider.observableRequestCallsCount, 1)
        XCTAssertEqual(databaseProvider.saveObjectCallsCount, 2)
    }
}
