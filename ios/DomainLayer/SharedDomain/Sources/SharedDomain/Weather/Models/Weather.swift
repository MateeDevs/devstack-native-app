//
//  Created by Adam Penaz on 16.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public struct Weather {
    public let conditionID: Int
    public let cityName: String
    public let temperature: Double
    public let units: WeatherUnits
    
    public init (
        conditionID: Int,
        cityName: String,
        temperature: Double,
        units: WeatherUnits
    ) {
        self.conditionID = conditionID
        self.cityName = cityName
        self.temperature = temperature
        self.units = units
    }
}
