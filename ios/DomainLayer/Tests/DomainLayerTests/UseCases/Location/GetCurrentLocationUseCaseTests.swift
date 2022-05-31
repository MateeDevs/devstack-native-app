//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import DomainLayer
import RepositoryMocks
import SwiftyMocky
import XCTest

class GetCurrentLocationUseCaseTests: BaseTestCase {
    
    private let locationStub = CLLocation(latitude: 50.0, longitude: 50.0)
    
    // MARK: Dependencies
    
    private let locationRepository = LocationRepositoryMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        let locationStream = AsyncStream(CLLocation.self) { continuation in
            continuation.yield(locationStub)
            continuation.finish()
        }
        
        Given(locationRepository, .readCurrentLocation(withAccuracy: .any, willReturn: locationStream))
    }
    
    // MARK: Tests

    func testExecute() async {
        let useCase = GetCurrentLocationUseCaseImpl(locationRepository: locationRepository)
        
        let currentLocationStream = useCase.execute()
        
        for try await currentLocation in currentLocationStream {
            XCTAssertEqual(currentLocation, locationStub)
        }
        Verify(locationRepository, 1, .readCurrentLocation(withAccuracy: .value(kCLLocationAccuracyThreeKilometers)))
    }
}
