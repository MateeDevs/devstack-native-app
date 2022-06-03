//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import AnalyticsProvider
import AnalyticsProviderMocks
import AnalyticsToolkit
import SharedDomain
import Utilities
import XCTest

final class AnalyticsRepositoryTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let analyticsProvider = AnalyticsProviderMock()
    
    private func createRepository() -> AnalyticsRepository {
        AnalyticsRepositoryImpl(analyticsProvider: analyticsProvider)
    }
    
    // MARK: Tests
    
    func testCreate() {
        let event = LoginEvent.screenAppear.analyticsEvent
        let repository = createRepository()
        
        repository.create(event)
        
        XCTAssert(analyticsProvider.trackParamsReceivedInvocations == [(event.name, event.params)])
    }
}
