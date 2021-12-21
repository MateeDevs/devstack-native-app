//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
@testable import PresentationLayer
import RxSwift
import RxTest
import SwiftyMocky
import UseCaseMocks
import XCTest

class UsersViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let dbStream = BehaviorSubject<[User]>(value: User.stubList)
    
    private let getUsersUseCase = GetUsersUseCaseMock()
    private let refreshUsersUseCase = RefreshUsersUseCaseMock()
    
    private func setupDependencies() -> UseCaseDependency {
        Given(getUsersUseCase, .execute(willReturn: dbStream.asObservable()))
        Given(refreshUsersUseCase, .execute(page: .any, willReturn: .just(Constants.paginationCount)))
        
        return UseCaseDependencyMock(
            getUsersUseCase: getUsersUseCase,
            refreshUsersUseCase: refreshUsersUseCase
        )
    }
    
    // MARK: Inputs and outputs
    
    private struct Input {
        var page: [(time: TestTime, element: Int)] = []
        
        static let initialLoad = Input(page: [(0, 0)])
    }
    
    private struct Output {
        let users: TestableObserver<[User]>
        let loadedCount: TestableObserver<Int>
        let isRefreshing: TestableObserver<Bool>
    }
    
    private func generateOutput(for input: Input) -> Output {
        let viewModel = UsersViewModel(dependencies: setupDependencies())
        
        scheduler.createColdObservable(input.page.map { .next($0.time, $0.element) })
            .do { [weak self] _ in self?.dbStream.onNext(User.stubList) }
            .bind(to: viewModel.input.page).disposed(by: disposeBag)
        
        return Output(
            users: testableOutput(from: viewModel.output.users),
            loadedCount: testableOutput(from: viewModel.output.loadedCount),
            isRefreshing: testableOutput(from: viewModel.output.isRefreshing)
        )
    }
    
    // MARK: Tests
    
    func testInitialLoad() {
        let output = generateOutput(for: .initialLoad)
        
        scheduler.start()
        
        XCTAssertEqual(output.users.events, [
            .next(0, User.stubList),
            .next(0, User.stubList)
        ])
        XCTAssertEqual(output.loadedCount.events, [
            .next(0, Constants.paginationCount)
        ])
        XCTAssertEqual(output.isRefreshing.events, [
            .next(0, false),
            .next(0, true),
            .next(0, false),
            .next(0, false)
        ])
        Verify(getUsersUseCase, 1, .execute())
        Verify(refreshUsersUseCase, 1, .execute(page: 0))
    }
}
