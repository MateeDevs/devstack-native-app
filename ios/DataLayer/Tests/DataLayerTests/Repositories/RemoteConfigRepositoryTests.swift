//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DataLayer
import ProviderMocks
import SwiftyMocky
import XCTest

class RemoteConfigRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let remoteConfigProvider = RemoteConfigProviderMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(remoteConfigProvider, .read(.any, willReturn: true))
    }
    
    // MARK: Tests
    
    func testRead() async throws {
        let repository = RemoteConfigRepositoryImpl(remoteConfigProvider: remoteConfigProvider)
        
        let value = try await repository.read(.profileLabelIsVisible)
        
        XCTAssertEqual(value, true)
        Verify(remoteConfigProvider, 1, .read(.any))
    }
}
