//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DomainLayer
import RepositoryMocks
import Resolver
import SwiftyMocky
import XCTest

class TrackAnalyticsEventUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let analyticsRepository = AnalyticsRepositoryMock()

    override func registerDependencies() {
        super.registerDependencies()
        
        Resolver.register { self.analyticsRepository as AnalyticsRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = TrackAnalyticsEventUseCaseImpl()
        
        useCase.execute(LoginEvent.screenAppear.analyticsEvent)
        
        Verify(analyticsRepository, 1, .create(.value(LoginEvent.screenAppear.analyticsEvent)))
    }
}
