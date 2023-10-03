//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@testable import Recipes
import Resolver
@testable import SharedDomain
import UIToolkit
import XCTest

@MainActor
final class CounterViewModelTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let fc = FlowControllerMock<RecipesFlow>(navigationController: UINavigationController())
    
    private let getProfileUseCase = GetProfileUseCaseSpy()
    private let updateProfileCounterUseCase = UpdateProfileCounterUseCaseSpy()
    
    private func createViewModel() -> CounterViewModel {
        Resolver.register { self.getProfileUseCase as GetProfileUseCase }
        Resolver.register { self.updateProfileCounterUseCase as UpdateProfileCounterUseCase }
        
        return CounterViewModel(flowController: fc)
    }

    // MARK: Tests
    
    func testAppear() async {
        let vm = createViewModel()
        getProfileUseCase.executeReturnValue = User.stub
        
        vm.onAppear()
        await vm.awaitAllTasks()
        
        XCTAssertEqual(vm.state.value, 0)
        XCTAssert(getProfileUseCase.executeReceivedInvocations == [.local])
    }
    
    func testIncrease() async {
        let vm = createViewModel()
        
        vm.onIntent(.increase)
        await vm.awaitAllTasks()
        
        XCTAssertEqual(vm.state.value, 1)
        XCTAssert(updateProfileCounterUseCase.executeValueReceivedInvocations == [1])
    }
    
    func testDecrease() async {
        let vm = createViewModel()
        
        vm.onIntent(.decrease)
        await vm.awaitAllTasks()
        
        XCTAssertEqual(vm.state.value, -1)
        XCTAssert(updateProfileCounterUseCase.executeValueReceivedInvocations == [-1])
    }
}
