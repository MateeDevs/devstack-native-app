//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DependencyInjection
import Factory
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
        Container.shared.reset()
        Container.shared.getUsersUseCase.register { self.getUsersUseCase }
        
        return UsersViewModel(flowController: fc)
    }

    // MARK: Tests
    
    func testAppear() async {
        let vm = createViewModel()
        getUsersUseCase.executePageLimitReturnValue = Pages<User>.stub
        
        vm.onAppear()
        await vm.awaitAllTasks()
        
        XCTAssertEqual(vm.state.users, Pages<User>.stub.data)
        XCTAssertEqual(vm.state.isLoading, false)
        XCTAssert(getUsersUseCase.executePageLimitReceivedInvocations == [
            (.local, 0, 100),
            (.remote, 0, 100)
        ])
    }
    
    func testOpenUserDetail() async {
        let vm = createViewModel()
        
        vm.onIntent(.openUserDetail(id: User.stub.id))
        await vm.awaitAllTasks()
        
        XCTAssertEqual(fc.handleFlowValue, .users(.showUserDetailForId(User.stub.id)))
    }
}
