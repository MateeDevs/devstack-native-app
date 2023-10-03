//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
@testable import SharedDomain
import UIToolkit
@testable import Users
import Utilities
import XCTest

@MainActor
final class UserDetailViewModelTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let fc = FlowControllerMock<UsersFlow>(navigationController: UINavigationController())
    
    private let getUserUseCase = GetUserUseCaseSpy()
    private let trackAnalyticsEventUseCase = TrackAnalyticsEventUseCaseSpy()
    
    private func createViewModel() -> UserDetailViewModel {
        Resolver.register { self.getUserUseCase as GetUserUseCase }
        Resolver.register { self.trackAnalyticsEventUseCase as TrackAnalyticsEventUseCase }
        
        return UserDetailViewModel(userId: User.stub.id, flowController: fc)
    }

    // MARK: Tests
    
    func testAppear() async {
        let vm = createViewModel()
        getUserUseCase.executeIdReturnValue = User.stub
        
        vm.onAppear()
        await vm.awaitAllTasks()
        
        XCTAssertEqual(vm.state.user, User.stub)
        XCTAssert(getUserUseCase.executeIdReceivedInvocations == [
            (.local, User.stub.id),
            (.remote, User.stub.id)
        ])
        XCTAssert(trackAnalyticsEventUseCase.executeReceivedInvocations == [UserEvent.userDetail(id: User.stub.id).analyticsEvent])
    }
}
