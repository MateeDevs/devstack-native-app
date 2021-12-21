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

class SettingsViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private func setupDependencies() -> UseCaseDependency {
        UseCaseDependencyMock()
    }

    // MARK: Inputs and outputs

    private struct Input {
        var smallButtonTaps: [(time: TestTime, element: Void)] = []
        var largeButtonTaps: [(time: TestTime, element: Void)] = []

        static let small = Input(smallButtonTaps: [(0, ())])
        static let large = Input(largeButtonTaps: [(0, ())])
    }
    
    private struct Output {
        let topViewHeight: TestableObserver<CGFloat>
    }

    private func generateOutput(for input: Input) -> Output {
        let viewModel = SettingsViewModel(dependencies: setupDependencies())

        scheduler.createColdObservable(input.smallButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.smallButtonTaps).disposed(by: disposeBag)

        scheduler.createColdObservable(input.largeButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.largeButtonTaps).disposed(by: disposeBag)
        
        return Output(
            topViewHeight: testableOutput(from: viewModel.output.topViewHeight)
        )
    }

    // MARK: Tests

    func testSmall() {
        let output = generateOutput(for: .small)
        
        scheduler.start()
        
        XCTAssertEqual(output.topViewHeight.events, [
            .next(0, 300)
        ])
    }

    func testLarge() {
        let output = generateOutput(for: .large)
        
        scheduler.start()
        
        XCTAssertEqual(output.topViewHeight.events, [
            .next(0, 1200)
        ])
    }
}
