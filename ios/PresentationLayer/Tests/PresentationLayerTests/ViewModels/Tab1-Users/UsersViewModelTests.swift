//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
@testable import PresentationLayer
import Resolver
import SwiftyMocky
import UseCaseMocks
import XCTest

class UsersViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let getUsersUseCase = GetUsersUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Resolver.register { self.getUsersUseCase as GetUsersUseCase }
        
        Given(getUsersUseCase, .execute(.any, page: .any, willReturn: [User].stub))
    }

    // MARK: Tests
    
    func testAppear() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = UsersViewModel(flowController: fc)
        
        vm.onAppear()
        for task in vm.tasks { await task.value }
        
        XCTAssertEqual(vm.state.users, [User].stub)
        XCTAssertEqual(vm.state.isLoading, false)
        Verify(getUsersUseCase, 1, .execute(.value(.local), page: .any))
        Verify(getUsersUseCase, 1, .execute(.value(.remote), page: .any))
    }
    
    func testOpenUserDetail() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = UsersViewModel(flowController: fc)
        
        await vm.onIntent(.openUserDetail(id: User.stub.id)).value
        
        XCTAssertEqual(fc.handleFlowValue, .users(.showUserDetailForId(User.stub.id)))
    }
}
