//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
@testable import PresentationLayer
import RxSwift
import RxTest
import SwiftyMocky
import UseCaseMocks
import XCTest

class CounterControlViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let updateProfileCounterUseCase = UpdateProfileCounterUseCaseMock()
    
    private func setupDependencies() -> UseCaseDependency {
        Given(updateProfileCounterUseCase, .execute(value: .any, willReturn: .just(())))
        return UseCaseDependencyMock(updateProfileCounterUseCase: updateProfileCounterUseCase)
    }

    // MARK: Inputs and outputs

    private struct Input {
        var increaseButtonTaps: [(time: TestTime, element: Void)] = []
        var decreaseButtonTaps: [(time: TestTime, element: Void)] = []

        static let increase = Input(increaseButtonTaps: [(0, ())])
        static let decrease = Input(decreaseButtonTaps: [(0, ())])
    }
    
    private struct Output {
        let increaseCounter: TestableObserver<Bool>
        let decreaseCounter: TestableObserver<Bool>
    }

    private func generateOutput(for input: Input) -> Output {
        let viewModel = CounterControlViewModel(dependencies: setupDependencies())

        scheduler.createColdObservable(input.increaseButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.increaseButtonTaps).disposed(by: disposeBag)

        scheduler.createColdObservable(input.decreaseButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.decreaseButtonTaps).disposed(by: disposeBag)
        
        return Output(
            increaseCounter: testableOutput(from: viewModel.output.increaseCounter.map { _ in true }),
            decreaseCounter: testableOutput(from: viewModel.output.decreaseCounter.map { _ in true })
        )
    }

    // MARK: Tests

    func testIncrease() {
        let output = generateOutput(for: .increase)
        
        scheduler.start()
        
        XCTAssertEqual(output.increaseCounter.events, [
            .next(0, true)
        ])
        XCTAssertEqual(output.decreaseCounter.events, [])
        Verify(updateProfileCounterUseCase, 1, .execute(value: 1))
    }

    func testDecrease() {
        let output = generateOutput(for: .decrease)
        
        scheduler.start()
        
        XCTAssertEqual(output.increaseCounter.events, [])
        XCTAssertEqual(output.decreaseCounter.events, [
            .next(0, true)
        ])
        Verify(updateProfileCounterUseCase, 1, .execute(value: -1))
    }
}
