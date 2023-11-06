//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
@testable import SharedDomain
import XCTest

final class GetCurrentLocationUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let locationRepository = LocationRepositorySpy()
    
    // MARK: Tests

    func testExecute() async {
        let location = CLLocation(latitude: 50.0, longitude: 50.0)
        let useCase = GetCurrentLocationUseCaseImpl(locationRepository: locationRepository)
        locationRepository.readCurrentLocationWithAccuracyReturnValue = AsyncStream(CLLocation.self) { continuation in
            continuation.yield(location)
            continuation.finish()
        }
        
        let currentLocationStream = useCase.execute()
        
        for try await currentLocation in currentLocationStream {
            XCTAssertEqual(currentLocation, location)
        }
        XCTAssert(locationRepository.readCurrentLocationWithAccuracyReceivedInvocations == [kCLLocationAccuracyThreeKilometers])
    }
}
