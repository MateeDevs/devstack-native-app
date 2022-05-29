//
//  Created by Petr Chmelar on 24.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import CoreLocation
import LocationProvider
import LocationProviderMocks
import LocationToolkit
import SharedDomain
import XCTest

class LocationRepositoryTests: XCTestCase {
    
    private let location = CLLocation(latitude: 50.0, longitude: 50.0)
    
    // MARK: Dependencies
    
    private let locationProvider = LocationProviderMock()

    private func createRepository() -> LocationRepository {
        LocationRepositoryImpl(locationProvider: locationProvider)
    }
    
    // MARK: Tests
    
    func testReadIsLocationEnabled() {
        let repository = createRepository()
        locationProvider.isLocationEnabledReturnValue = true
        
        let isLocationEnabled = repository.readIsLocationEnabled()
        
        XCTAssertEqual(isLocationEnabled, true)
        XCTAssertEqual(locationProvider.isLocationEnabledCallsCount, 1)
    }
    
    func testReadCurrentLocation() async {
        let repository = createRepository()
        locationProvider.getCurrentLocationWithAccuracyReturnValue = AsyncStream(CLLocation.self) { continuation in
            continuation.yield(location)
            continuation.finish()
        }
        
        let currentLocationStream = repository.readCurrentLocation(withAccuracy: kCLLocationAccuracyThreeKilometers)
        
        for try await currentLocation in currentLocationStream {
            XCTAssertEqual(currentLocation, location)
        }
        XCTAssert(locationProvider.getCurrentLocationWithAccuracyReceivedInvocations == [kCLLocationAccuracyThreeKilometers])
    }
}
