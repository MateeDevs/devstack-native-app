//
//  Created by Adam Penaz on 16.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public struct Weather {
    public let conditionID: Int
    public let cityName: String
    public let temperature: Double
    
    public init (
        conditionID: Int,
        cityName: String,
        temperature: Double
    ) {
        self.conditionID = conditionID
        self.cityName = cityName
        self.temperature = temperature
    }
}

public extension Weather {
    var temperatureString: String {
        String(format: "%.1f", temperature)
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
