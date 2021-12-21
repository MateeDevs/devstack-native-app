//
//  Created by Petr Chmelar on 26.03.2021
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

class UserDetailViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let dbStream = BehaviorSubject<User>(value: User.stub)
    
    private let getUserUseCase = GetUserUseCaseMock()
    private let refreshUserUseCase = RefreshUserUseCaseMock()
    
    private func setupDependencies() -> UseCaseDependency {
        Given(getUserUseCase, .execute(id: .value(User.stub.id), willReturn: dbStream.asObservable()))
        Given(refreshUserUseCase, .execute(id: .value(User.stub.id), willReturn: .just(())))
        
        return UseCaseDependencyMock(
            getUserUseCase: getUserUseCase,
            refreshUserUseCase: refreshUserUseCase
        )
    }
    
    // MARK: Inputs and outputs
    
    private struct Input {
        var refreshTrigger: [(time: TestTime, element: Void)] = []
        
        static let initialLoad = Input(refreshTrigger: [(0, ())])
    }
    
    private struct Output {
        let user: OutputUser
        let isRefreshing: TestableObserver<Bool>
    }
    
    private struct OutputUser {
        let fullName: TestableObserver<String>
        let initials: TestableObserver<String>
        let imageURL: TestableObserver<String?>
    }
    
    private func generateOutput(for input: Input) -> Output {
        let viewModel = UserDetailViewModel(dependencies: setupDependencies(), userId: User.stub.id)
        
        scheduler.createColdObservable(input.refreshTrigger.map { .next($0.time, $0.element) })
            .do { [weak self] _ in self?.dbStream.onNext(User.stub) }
            .bind(to: viewModel.input.refreshTrigger).disposed(by: disposeBag)
        
        return Output(
            user: OutputUser(
                fullName: testableOutput(from: viewModel.output.user.fullName),
                initials: testableOutput(from: viewModel.output.user.initials),
                imageURL: testableOutput(from: viewModel.output.user.imageURL)
            ),
            isRefreshing: testableOutput(from: viewModel.output.isRefreshing)
        )
    }
    
    // MARK: Tests
    
    func testInitialLoad() {
        let output = generateOutput(for: .initialLoad)
        
        scheduler.start()
        
        XCTAssertEqual(output.user.fullName.events, [
            .next(0, User.stub.fullName),
            .next(0, User.stub.fullName)
        ])
        XCTAssertEqual(output.user.initials.events, [
            .next(0, User.stub.fullName.initials),
            .next(0, User.stub.fullName.initials)
        ])
        XCTAssertEqual(output.user.imageURL.events, [
            .next(0, User.stub.pictureUrl),
            .next(0, User.stub.pictureUrl)
        ])
        XCTAssertEqual(output.isRefreshing.events, [
            .next(0, false),
            .next(0, true),
            .next(0, false),
            .next(0, false)
        ])
        Verify(getUserUseCase, 1, .execute(id: .value(User.stub.id)))
        Verify(refreshUserUseCase, 1, .execute(id: .value(User.stub.id)))
    }
}
