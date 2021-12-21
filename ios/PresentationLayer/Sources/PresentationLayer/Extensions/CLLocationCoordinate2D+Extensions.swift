//
//  Created by Petr Chmelar on 10/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D {

    /// Conversion from CLLocationCoordinate2D to String.
    func toString(withPlaces places: Int = 4) -> String {
        return "\(latitude.rounded(toPlaces: places)); \(longitude.rounded(toPlaces: places))"
    }
}
