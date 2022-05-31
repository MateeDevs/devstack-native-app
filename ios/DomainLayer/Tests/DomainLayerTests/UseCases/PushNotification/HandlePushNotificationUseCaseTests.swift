//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
import RepositoryMocks
import SwiftyMocky
import XCTest

class HandlePushNotificationUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsRepository = PushNotificationsRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        // We should test against concrete value instead of any, but I don't know how to mock [AnyHashable:Any]
        Given(pushNotificationsRepository, .decode(.any, willReturn: PushNotification.stub))
    }
    
    // MARK: Tests

    func testExecute() throws {
        let useCase = HandlePushNotificationUseCaseImpl(pushNotificationsRepository: pushNotificationsRepository)
        
        let pushNotification = try useCase.execute([:])
        
        XCTAssertEqual(pushNotification, PushNotification.stub)
        Verify(pushNotificationsRepository, 1, .decode(.any))
    }
}
