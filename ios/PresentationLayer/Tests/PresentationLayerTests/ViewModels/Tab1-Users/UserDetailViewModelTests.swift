//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
@testable import PresentationLayer
import Resolver
import SwiftyMocky
import UseCaseMocks
import XCTest

class UserDetailViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let getUserUseCase = GetUserUseCaseMock()
    private let trackAnalyticsEventUseCase = TrackAnalyticsEventUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Resolver.register { self.getUserUseCase as GetUserUseCase }
        Resolver.register { self.trackAnalyticsEventUseCase as TrackAnalyticsEventUseCase }
        
        Given(getUserUseCase, .execute(.any, id: .value(User.stub.id), willReturn: User.stub))
    }

    // MARK: Tests
    
    func testAppear() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = UserDetailViewModel(userId: User.stub.id, flowController: fc)
        
        vm.onAppear()
        for task in vm.tasks { await task.value }
        
        XCTAssertEqual(vm.state.user, User.stub)
        Verify(getUserUseCase, 1, .execute(.value(.local), id: .value(User.stub.id)))
        Verify(getUserUseCase, 1, .execute(.value(.remote), id: .value(User.stub.id)))
        Verify(trackAnalyticsEventUseCase, 1, .execute(.value(UserEvent.userDetail(id: User.stub.id).analyticsEvent)))
    }
}
