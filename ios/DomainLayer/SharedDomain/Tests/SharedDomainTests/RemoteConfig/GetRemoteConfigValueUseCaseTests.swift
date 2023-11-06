//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class GetRemoteConfigValueUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let remoteConfigRepository = RemoteConfigRepositorySpy()
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetRemoteConfigValueUseCaseImpl(remoteConfigRepository: remoteConfigRepository)
        remoteConfigRepository.readReturnValue = true
        
        let value = try await useCase.execute(.profileLabelIsVisible)
        
        XCTAssertEqual(value, true)
        XCTAssert(remoteConfigRepository.readReceivedInvocations == [.profileLabelIsVisible])
    }
}
