//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import PushNotificationsProvider
import PushNotificationsProviderMocks
import PushNotificationsToolkit
import SharedDomain
import XCTest

final class PushNotificationsRepositoryTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsProvider = PushNotificationsProviderMock()
    
    private func createRepository() -> PushNotificationsRepository {
        PushNotificationsRepositoryImpl(pushNotificationsProvider: pushNotificationsProvider)
    }
    
    // MARK: Tests
    
    func testRead() {
        let repository = createRepository()
        
        repository.register(options: [.alert, .badge, .sound], completionHandler: { _, _ in })

        XCTAssertEqual(pushNotificationsProvider.requestAuthorizationOptionsCompletionHandlerCallsCount, 1)
    }
}
