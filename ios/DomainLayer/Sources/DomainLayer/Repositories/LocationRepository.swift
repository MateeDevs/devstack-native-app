//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation

public protocol LocationRepository: AutoMockable {
    func readIsLocationEnabled() -> Bool
    func readCurrentLocation(withAccuracy accuracy: CLLocationAccuracy) -> AsyncStream<CLLocation>
}
