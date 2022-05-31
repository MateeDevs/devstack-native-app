//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import CoreLocation
import DomainLayer

public protocol LocationProvider: AutoMockable {
    
    /// Check whether the location services are enabled and authorized
    func isLocationEnabled() -> Bool
    
    /// Observe current location
    func getCurrentLocation(withAccuracy accuracy: CLLocationAccuracy) -> AsyncStream<CLLocation>
}
