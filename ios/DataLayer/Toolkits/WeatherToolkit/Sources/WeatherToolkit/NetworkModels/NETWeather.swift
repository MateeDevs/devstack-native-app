//
//  Created by Adam Penaz on 19.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain

struct NETWeather: Codable {
    let name: String
    let main: NETMain
    let weather: [NETWeatherIcon]
}

struct NETMain: Codable {
    let temp: Double
}

struct NETWeatherIcon: Codable {
    let id: Int
}

// Units for API
enum NETWeatherUnitsAPI: String {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

// Conversion from NetworkModel to DomainModel
extension NETWeather {
    func domainModel(units: WeatherUnits) -> Weather {
        Weather(
            conditionID: weather[0].id,
            cityName: name,
            temperature: main.temp,
            units: units
        )
    }
}

// Conversion from DomainModelUnits to NetworkModelUnits
extension WeatherUnits {
    var networkModel: NETWeatherUnitsAPI {
        switch self {
        case .celsius: return .celsius
        case .fahrenheit: return .fahrenheit
        }
    }
}
