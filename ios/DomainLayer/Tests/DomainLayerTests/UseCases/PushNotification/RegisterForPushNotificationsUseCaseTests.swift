//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DomainLayer
import RepositoryMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class RegisterForPushNotificationsUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let pushNotificationsRepository = PushNotificationsRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Resolver.register { self.pushNotificationsRepository as PushNotificationsRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = RegisterForPushNotificationsUseCaseImpl()
        
        useCase.execute(options: [.alert, .badge, .sound], completionHandler: { _, _ in })
        
        Verify(pushNotificationsRepository, 1, .register(options: .value([.alert, .badge, .sound]), completionHandler: .any))
    }
}
