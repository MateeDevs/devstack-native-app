//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DataLayer
import DomainLayer
import ProviderMocks
import Resolver
import SwiftyMocky
import XCTest

class AnalyticsRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let analyticsProvider = AnalyticsProviderMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Resolver.register { self.analyticsProvider as AnalyticsProvider }
    }
    
    // MARK: Tests
    
    func testCreate() {
        let repository = AnalyticsRepositoryImpl()
        
        repository.create(LoginEvent.screenAppear.analyticsEvent)
        
        Verify(analyticsProvider, 1, .track(.value(LoginEvent.screenAppear.analyticsEvent)))
    }
}
