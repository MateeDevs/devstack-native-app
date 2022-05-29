//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SharedDomainMocks
@testable import Users
import Utilities
import XCTest

@MainActor
class UsersViewModelTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let fc = UsersFlowController(navigationController: UINavigationController())
    
    private let getUsersUseCase = GetUsersUseCaseMock()
    
    private func createViewModel() -> UsersViewModel {
        Resolver.register { self.getUsersUseCase as GetUsersUseCase }
        
        return UsersViewModel(flowController: fc)
    }

    // MARK: Tests
    
    func testAppear() async {
        let vm = createViewModel()
        getUsersUseCase.executePageReturnValue = [User].stub
        
        vm.onAppear()
        for task in vm.tasks { await task.value }
        
        XCTAssertEqual(vm.state.users, [User].stub)
        XCTAssertEqual(vm.state.isLoading, false)
        XCTAssert(getUsersUseCase.executePageReceivedInvocations == [
            (.local, 0),
            (.remote, 0)
        ])
    }
    
    func testOpenUserDetail() async {
        let vm = createViewModel()
        
        await vm.onIntent(.openUserDetail(id: User.stub.id)).value
        
        // XCTAssertEqual(fc.handleFlowValue, .users(.showUserDetailForId(User.stub.id)))
    }
}
