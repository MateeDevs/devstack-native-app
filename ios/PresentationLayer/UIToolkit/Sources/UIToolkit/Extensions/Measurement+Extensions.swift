//
//  Created by Petr Chmelar on 10/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

public extension Measurement where UnitType == Dimension {
    
    /// Predefined default unit for selected dimensions
    var defaultUnit: Measurement {
        switch unit {
        case is UnitLength: converted(to: UnitLength.kilometers)
        case is UnitMass: converted(to: UnitMass.kilograms)
        case is UnitSpeed: converted(to: UnitSpeed.kilometersPerHour)
        case is UnitTemperature: converted(to: UnitTemperature.celsius)
        case is UnitVolume: converted(to: UnitVolume.liters)
        default: self
        }
    }
    
    /// Predefined default minimum/maximum fraction digits for selected dimensions
    private var defaultFractionDigits: (minimum: Int, maximum: Int) {
        switch unit {
        case is UnitLength: (0, 0)
        case is UnitMass: (0, 0)
        case is UnitSpeed: (0, 0)
        case is UnitTemperature: (0, 0)
        case is UnitVolume: (0, 0)
        default: (0, 0)
        }
    }
    
    ///
    /// Dimension formatting based on user's locale/preferences
    ///
    /// - parameter minimumFractionDigits: Specify minimum number of fraction digits
    /// - parameter maximumFractionDigits: Specify maximum number of fraction digits
    /// - returns: Formatted dimension
    ///
    func formatted(minimumFractionDigits: Int? = nil, maximumFractionDigits: Int? = nil) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.minimumFractionDigits = minimumFractionDigits ?? defaultFractionDigits.minimum
        formatter.numberFormatter.maximumFractionDigits = maximumFractionDigits ?? defaultFractionDigits.maximum
        return formatter.string(from: self)
    }
}
