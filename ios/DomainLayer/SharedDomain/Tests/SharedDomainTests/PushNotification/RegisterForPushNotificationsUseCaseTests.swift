//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain
import SharedDomainMocks
import XCTest

class RegisterForPushNotificationsUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsRepository = PushNotificationsRepositoryMock()
    
    // MARK: Tests

    func testExecute() {
        let useCase = RegisterForPushNotificationsUseCaseImpl(pushNotificationsRepository: pushNotificationsRepository)
        
        useCase.execute(options: [.alert, .badge, .sound], completionHandler: { _, _ in })
        
        XCTAssertEqual(pushNotificationsRepository.registerOptionsCompletionHandlerCallsCount, 1)
    }
}
