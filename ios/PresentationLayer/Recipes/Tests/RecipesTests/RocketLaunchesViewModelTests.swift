//
//  Created by Petr Chmelar on 08.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DependencyInjection
import Factory
@testable import Recipes
@testable import SharedDomain
import UIToolkit
import XCTest

@MainActor
final class RocketLaunchesViewModelTests: XCTestCase {

    // MARK: Dependencies
    
    private let fc = FlowControllerMock<RecipesFlow>(navigationController: UINavigationController())
    
    private let getRocketLaunchesUseCase = GetRocketLaunchesUseCaseSpy()
    
    private func createViewModel() -> RocketLaunchesViewModel {
        Container.shared.reset()
        Container.shared.getRocketLaunchesUseCase.register { self.getRocketLaunchesUseCase }
        
        return RocketLaunchesViewModel(flowController: fc)
    }

    // MARK: Tests
    
    func testAppear() async {
        let vm = createViewModel()
        getRocketLaunchesUseCase.executeReturnValue = AsyncThrowingStream([RocketLaunch].self) { continuation in
            continuation.yield([RocketLaunch].stub)
            continuation.finish()
        }
        
        vm.onAppear()
        await vm.awaitAllTasks()
        
        XCTAssertEqual(vm.state.rocketLaunches, [RocketLaunch].stub)
        XCTAssertEqual(vm.state.isLoading, false)
        XCTAssertEqual(getRocketLaunchesUseCase.executeCallsCount, 1)
    }
}
