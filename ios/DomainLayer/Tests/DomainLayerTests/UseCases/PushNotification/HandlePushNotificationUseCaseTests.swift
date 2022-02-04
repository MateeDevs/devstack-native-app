//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DomainLayer
import DomainStubs
import RepositoryMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class HandlePushNotificationUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsRepository = PushNotificationsRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        // We should test against concrete value instead of any, but I don't know how to mock [AnyHashable:Any]
        Given(pushNotificationsRepository, .decode(.any, willReturn: PushNotification.stub))
        
        Resolver.register { self.pushNotificationsRepository as PushNotificationsRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = HandlePushNotificationUseCaseImpl()
        
        let output = useCase.execute([:])
        
        XCTAssertEqual(output, PushNotification.stub)
        Verify(pushNotificationsRepository, 1, .decode(.any))
    }
}
