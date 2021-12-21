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

class CounterSharedViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private func setupDependencies() -> UseCaseDependency {
        UseCaseDependencyMock()
    }

    // MARK: Inputs and outputs

    private struct Input {
        var hideButtonIsOn: [(time: TestTime, element: Bool)] = []

        static let hideButtonIsOn = Input(hideButtonIsOn: [(0, true)])
        static let hideButtonIsOff = Input(hideButtonIsOn: [(0, false)])
    }
    
    private struct Output {
        let isCounterHidden: TestableObserver<Bool>
    }

    private func generateOutput(for input: Input) -> Output {
        let viewModel = CounterSharedViewModel(dependencies: setupDependencies())

        scheduler.createColdObservable(input.hideButtonIsOn.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.hideButtonIsOn).disposed(by: disposeBag)
        
        return Output(
            isCounterHidden: testableOutput(from: viewModel.output.isCounterHidden)
        )
    }

    // MARK: Tests

    func testHideButtonIsOn() {
        let output = generateOutput(for: .hideButtonIsOn)
        
        scheduler.start()
        
        XCTAssertEqual(output.isCounterHidden.events, [
            .next(0, true)
        ])
    }

    func testDecrease() {
        let output = generateOutput(for: .hideButtonIsOff)
        
        scheduler.start()
        
        XCTAssertEqual(output.isCounterHidden.events, [
            .next(0, false)
        ])
    }
}
