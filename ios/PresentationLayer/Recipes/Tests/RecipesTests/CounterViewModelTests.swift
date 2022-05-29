//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@testable import Recipes
import Resolver
import SharedDomain
import SharedDomainMocks
import XCTest

@MainActor
class CounterViewModelTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let fc = RecipesFlowController(navigationController: UINavigationController())
    
    private let getProfileUseCase = GetProfileUseCaseMock()
    private let updateProfileCounterUseCase = UpdateProfileCounterUseCaseMock()
    
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
        for task in vm.tasks { await task.value }
        
        XCTAssertEqual(vm.state.value, 0)
        XCTAssert(getProfileUseCase.executeReceivedInvocations == [.local])
    }
    
    func testIncrease() async {
        let vm = createViewModel()
        
        await vm.onIntent(.increase).value
        
        XCTAssertEqual(vm.state.value, 1)
        XCTAssert(updateProfileCounterUseCase.executeValueReceivedInvocations == [1])
    }
    
    func testDecrease() async {
        let vm = createViewModel()
        
        await vm.onIntent(.decrease).value
        
        XCTAssertEqual(vm.state.value, -1)
        XCTAssert(updateProfileCounterUseCase.executeValueReceivedInvocations == [-1])
    }
}
