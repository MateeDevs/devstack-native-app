//
//  Created by Adam Penaz on 19.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import SharedDomain

extension UnitTemperature {
    static var current: WeatherUnits {
        let measureFormatter = MeasurementFormatter()
        let measurement = Measurement(value: 0, unit: UnitTemperature.celsius)
        let output = measureFormatter.string(from: measurement)
        return output == "0°C" ? .celsius : .fahrenheit
    }
}
