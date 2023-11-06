//
//  Created by Petr Chmelar on 08.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class GetRocketLaunchesUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let rocketLaunchRepository = RocketLaunchRepositorySpy()
    
    // MARK: Tests

    func testExecute() async throws {
        let useCase = GetRocketLaunchesUseCaseImpl(rocketLaunchRepository: rocketLaunchRepository)
        rocketLaunchRepository.listReturnValue = AsyncThrowingStream([RocketLaunch].self) { continuation in
            continuation.yield([RocketLaunch].stub)
            continuation.finish()
        }
        
        let rocketLaunchesStream = useCase.execute()
        
        for try await rocketLaunches in rocketLaunchesStream {
            XCTAssertEqual(rocketLaunches, [RocketLaunch].stub)
        }
        XCTAssertEqual(rocketLaunchRepository.listCallsCount, 1)
    }
}
