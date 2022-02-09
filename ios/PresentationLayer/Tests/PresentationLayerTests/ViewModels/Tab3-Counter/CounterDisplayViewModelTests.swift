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

class CounterDisplayViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let getProfileUseCase = GetProfileUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(getProfileUseCase, .execute(willReturn: .just(User.stub)))
    }
    
    // MARK: Inputs and outputs
    
    private struct Input {
        static let initialLoad = Input()
    }
    
    private struct Output {
        let counterValue: TestableObserver<String>
    }
    
    private func generateOutput(for input: Input) -> Output {
        let viewModel = CounterDisplayViewModel(getProfileUseCase: getProfileUseCase)
        
        return Output(
            counterValue: testableOutput(from: viewModel.output.counterValue)
        )
    }
    
    // MARK: Tests
    
    func testInitialLoad() {
        let output = generateOutput(for: .initialLoad)
        
        scheduler.start()
        
        XCTAssertEqual(output.counterValue.events, [
            .next(0, "\(User.stub.counter)"),
            .completed(0)
        ])
        Verify(getProfileUseCase, 1, .execute())
    }
}
