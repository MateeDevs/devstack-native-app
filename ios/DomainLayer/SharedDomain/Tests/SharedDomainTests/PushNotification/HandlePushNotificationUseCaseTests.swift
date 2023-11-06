//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class HandlePushNotificationUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsRepository = PushNotificationsRepositorySpy()
    
    // MARK: Tests

    func testExecute() throws {
        let useCase = HandlePushNotificationUseCaseImpl(pushNotificationsRepository: pushNotificationsRepository)
        pushNotificationsRepository.decodeReturnValue = PushNotification.stub
        
        let pushNotification = try useCase.execute([:])
        
        XCTAssertEqual(pushNotification, PushNotification.stub)
        XCTAssertEqual(pushNotificationsRepository.decodeCallsCount, 1)
    }
}
