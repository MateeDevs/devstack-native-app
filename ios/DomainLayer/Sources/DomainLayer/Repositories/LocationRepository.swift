//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import RxSwift

public protocol HasLocationRepository {
    var locationRepository: LocationRepository { get }
}

public protocol LocationRepository: AutoMockable {
    
    /// Check whether the location services are enabled and authorized
    func isLocationEnabled() -> Bool
    
    /// Observe current location
    func getCurrentLocation(withAccuracy accuracy: CLLocationAccuracy) -> Observable<CLLocation>
}
