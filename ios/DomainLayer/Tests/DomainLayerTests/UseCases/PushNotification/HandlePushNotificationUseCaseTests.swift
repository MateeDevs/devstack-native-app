//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import RxSwift
import SwiftyMocky
import XCTest

class HandlePushNotificationUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsRepository = PushNotificationsRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        // We should test against concrete value instead of any, but I don't know how to mock [AnyHashable:Any]
        Given(pushNotificationsRepository, .decode(.any, willReturn: PushNotification.stub))
        return RepositoryDependencyMock(pushNotificationsRepository: pushNotificationsRepository)
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = HandlePushNotificationUseCaseImpl(dependencies: setupDependencies())
        
        let output = useCase.execute([:])
        
        XCTAssertEqual(output, PushNotification.stub)
        Verify(pushNotificationsRepository, 1, .decode(.any))
    }
}
