//
//  Created by Petr Chmelar on 08.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@testable import Recipes
import Resolver
import SharedDomain
import SharedDomainMocks
import UIToolkit
import XCTest

@MainActor
final class RocketLaunchesViewModelTests: XCTestCase {

    // MARK: Dependencies
    
    private let fc = FlowControllerMock<RecipesFlow>(navigationController: UINavigationController())
    
    private let getRocketLaunchesUseCase = GetRocketLaunchesUseCaseMock()
    
    private func createViewModel() -> RocketLaunchesViewModel {
        Resolver.register { self.getRocketLaunchesUseCase as GetRocketLaunchesUseCase }
        
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
