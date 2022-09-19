//
//  Created by Adam Penaz on 19.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain

public extension Weather {
    var temperatureString: String {
        switch units {
        case .celsius: return String(format: "%.1f°C", temperature)
        case .fahrenheit: return String(format: "%.1f°F", temperature)
        }
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 701...781: return "cloud.fog"
        case 800: return "sun.max"
        case 801...804: return "cloud.bolt"
        default: return "cloud"
        }
    }
}
