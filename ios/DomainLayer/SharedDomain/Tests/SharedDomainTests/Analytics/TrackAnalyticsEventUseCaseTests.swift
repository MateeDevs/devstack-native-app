//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class TrackAnalyticsEventUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let analyticsRepository = AnalyticsRepositorySpy()
    
    // MARK: Tests

    func testExecute() {
        let useCase = TrackAnalyticsEventUseCaseImpl(analyticsRepository: analyticsRepository)
        
        useCase.execute(LoginEvent.screenAppear.analyticsEvent)
        
        XCTAssert(analyticsRepository.createReceivedInvocations == [LoginEvent.screenAppear.analyticsEvent])
    }
}
