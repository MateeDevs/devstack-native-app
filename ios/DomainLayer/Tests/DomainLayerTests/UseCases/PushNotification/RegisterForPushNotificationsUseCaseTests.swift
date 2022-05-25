//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RepositoryMocks
import SwiftyMocky
import XCTest

class RegisterForPushNotificationsUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsRepository = PushNotificationsRepositoryMock()
    
    // MARK: Tests

    func testExecute() {
        let useCase = RegisterForPushNotificationsUseCaseImpl(pushNotificationsRepository: pushNotificationsRepository)
        
        useCase.execute(options: [.alert, .badge, .sound], completionHandler: { _, _ in })
        
        Verify(pushNotificationsRepository, 1, .register(options: .value([.alert, .badge, .sound]), completionHandler: .any))
    }
}
