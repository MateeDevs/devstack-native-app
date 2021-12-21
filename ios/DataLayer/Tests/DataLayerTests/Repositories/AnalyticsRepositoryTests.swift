//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DataLayer
import DomainLayer
import ProviderMocks
import SwiftyMocky
import XCTest

class AnalyticsRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let analyticsProvider = AnalyticsProviderMock()
    
    private func setupDependencies() -> ProviderDependency {
        return ProviderDependencyMock(analyticsProvider: analyticsProvider)
    }
    
    // MARK: Tests
    
    func testCreate() {
        let repository = AnalyticsRepositoryImpl(dependencies: setupDependencies())
        
        repository.create(LoginEvent.screenAppear.analyticsEvent)
        
        Verify(analyticsProvider, 1, .track(.value(LoginEvent.screenAppear.analyticsEvent)))
    }
}
