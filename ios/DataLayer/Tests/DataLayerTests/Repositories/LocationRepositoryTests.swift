//
//  Created by Petr Chmelar on 24.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import CoreLocation
import DataLayer
import DomainLayer
import ProviderMocks
import SwiftyMocky
import XCTest

class LocationRepositoryTests: BaseTestCase {
    
    private let location = CLLocation(latitude: 50.0, longitude: 50.0)
    
    // MARK: Dependencies
    
    private let locationProvider = LocationProviderMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        let locationStream = AsyncStream(CLLocation.self) { continuation in
            continuation.yield(location)
        }

        Given(locationProvider, .isLocationEnabled(willReturn: true))
        Given(locationProvider, .getCurrentLocation(withAccuracy: .any, willReturn: locationStream))
    }
    
    private func createRepository() -> LocationRepository {
        LocationRepositoryImpl(locationProvider: locationProvider)
    }
    
    // MARK: Tests
    
    func testIsLocationEnabled() {
        let repository = createRepository()
        
        let isLocationEnabled = repository.readIsLocationEnabled()
        
        XCTAssertEqual(isLocationEnabled, true)
        Verify(locationProvider, 1, .isLocationEnabled())
    }
    
    func testGetCurrentLocation() async {
        let repository = createRepository()
        
        let currentLocationStream = repository.readCurrentLocation(withAccuracy: kCLLocationAccuracyThreeKilometers)
        
        for try await currentLocation in currentLocationStream {
            XCTAssertEqual(currentLocation, location)
            break
        }
        Verify(locationProvider, 1, .getCurrentLocation(withAccuracy: .any))
    }
}
