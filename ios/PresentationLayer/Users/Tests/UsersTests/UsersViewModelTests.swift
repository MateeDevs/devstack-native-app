//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
@testable import SharedDomain
import UIToolkit
@testable import Users
import Utilities
import XCTest

@MainActor
final class UsersViewModelTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let fc = FlowControllerMock<UsersFlow>(navigationController: UINavigationController())
    
    private let getUsersUseCase = GetUsersUseCaseSpy()
    
    private func createViewModel() -> UsersViewModel {
        Resolver.register { self.getUsersUseCase as GetUsersUseCase }
        
        return UsersViewModel(flowController: fc)
    }

    // MARK: Tests
    
    func testAppear() async {
        let vm = createViewModel()
        getUsersUseCase.executePageReturnValue = [User].stub
        
        vm.onAppear()
        await vm.awaitAllTasks()
        
        XCTAssertEqual(vm.state.users, [User].stub)
        XCTAssertEqual(vm.state.isLoading, false)
        XCTAssert(getUsersUseCase.executePageReceivedInvocations == [
            (.local, 0),
            (.remote, 0)
        ])
    }
    
    func testOpenUserDetail() async {
        let vm = createViewModel()
        
        vm.onIntent(.openUserDetail(id: User.stub.id))
        await vm.awaitAllTasks()
        
        XCTAssertEqual(fc.handleFlowValue, .users(.showUserDetailForId(User.stub.id)))
    }
}
