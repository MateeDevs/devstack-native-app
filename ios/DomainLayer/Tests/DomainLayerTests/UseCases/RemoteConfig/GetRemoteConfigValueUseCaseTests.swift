//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RepositoryMocks
import SwiftyMocky
import XCTest

class GetRemoteConfigValueUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let remoteConfigRepository = RemoteConfigRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(remoteConfigRepository, .read(.any, willReturn: true))
    }
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetRemoteConfigValueUseCaseImpl(remoteConfigRepository: remoteConfigRepository)
        
        let value = try await useCase.execute(.profileLabelIsVisible)
        
        XCTAssertEqual(value, true)
        Verify(remoteConfigRepository, 1, .read(.value(.profileLabelIsVisible)))
    }
}
