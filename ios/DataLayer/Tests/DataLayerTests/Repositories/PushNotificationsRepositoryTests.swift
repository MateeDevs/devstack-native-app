//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DataLayer
import ProviderMocks
import RxSwift
import SwiftyMocky
import XCTest

class PushNotificationsRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsProvider = PushNotificationsProviderMock()
    
    private func setupDependencies() -> ProviderDependency {
        ProviderDependencyMock(pushNotificationsProvider: pushNotificationsProvider)
    }
    
    // MARK: Tests
    
    func testRead() {
        let repository = PushNotificationsRepositoryImpl(dependencies: setupDependencies())
        
        repository.register(options: [.alert, .badge, .sound], completionHandler: { _, _ in })

        Verify(pushNotificationsProvider, 1, .requestAuthorization(
            options: .value([.alert, .badge, .sound]),
            completionHandler: .any
        ))
    }
}
