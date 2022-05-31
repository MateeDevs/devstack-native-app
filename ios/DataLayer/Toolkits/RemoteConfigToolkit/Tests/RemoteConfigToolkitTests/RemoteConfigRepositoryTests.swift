//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RemoteConfigProvider
import RemoteConfigProviderMocks
import RemoteConfigToolkit
import SharedDomain
import XCTest

final class RemoteConfigRepositoryTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let remoteConfigProvider = RemoteConfigProviderMock()
    
    private func createRepository() -> RemoteConfigRepository {
        RemoteConfigRepositoryImpl(remoteConfigProvider: remoteConfigProvider)
    }
    
    // MARK: Tests
    
    func testRead() async throws {
        let repository = createRepository()
        remoteConfigProvider.readReturnValue = true
        
        let value = try await repository.read(.profileLabelIsVisible)
        
        XCTAssertEqual(value, true)
        XCTAssert(remoteConfigProvider.readReceivedInvocations == [RemoteConfigCoding.profileLabelIsVisible.rawValue])
    }
}
