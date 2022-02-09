//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RepositoryMocks
import SwiftyMocky
import XCTest

class TrackAnalyticsEventUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let analyticsRepository = AnalyticsRepositoryMock()
    
    // MARK: Tests

    func testExecute() {
        let useCase = TrackAnalyticsEventUseCaseImpl(analyticsRepository: analyticsRepository)
        
        useCase.execute(LoginEvent.screenAppear.analyticsEvent)
        
        Verify(analyticsRepository, 1, .create(.value(LoginEvent.screenAppear.analyticsEvent)))
    }
}
