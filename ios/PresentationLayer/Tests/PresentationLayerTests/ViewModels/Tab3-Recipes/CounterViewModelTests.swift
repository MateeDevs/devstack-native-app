//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
@testable import PresentationLayer
import Resolver
import SwiftyMocky
import UseCaseMocks
import XCTest

class CounterViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let getProfileUseCase = GetProfileUseCaseMock()
    private let updateProfileCounterUseCase = UpdateProfileCounterUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Resolver.register { self.getProfileUseCase as GetProfileUseCase }
        Resolver.register { self.updateProfileCounterUseCase as UpdateProfileCounterUseCase }
        
        Given(getProfileUseCase, .execute(.any, willReturn: User.stub))
    }

    // MARK: Tests
    
    func testAppear() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = CounterViewModel(flowController: fc)
        
        vm.onAppear()
        for task in vm.tasks { await task.value }
        
        XCTAssertEqual(vm.state.value, 0)
        Verify(getProfileUseCase, 1, .execute(.value(.local)))
    }
    
    func testIncrease() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = CounterViewModel(flowController: fc)
        
        await vm.onIntent(.increase).value
        
        XCTAssertEqual(vm.state.value, 1)
        Verify(updateProfileCounterUseCase, 1, .execute(value: 1))
    }
    
    func testDecrease() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = CounterViewModel(flowController: fc)
        
        await vm.onIntent(.decrease).value
        
        XCTAssertEqual(vm.state.value, -1)
        Verify(updateProfileCounterUseCase, 1, .execute(value: -1))
    }
}
