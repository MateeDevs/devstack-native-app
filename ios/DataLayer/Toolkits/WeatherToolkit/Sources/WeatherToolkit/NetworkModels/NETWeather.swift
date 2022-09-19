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

// Conversion from NetworkModel to DomainModel
extension NETWeather {
    var domainModel: Weather {
        Weather(
            conditionID: weather[0].id,
            cityName: name,
            temperature: main.temp
        )
    }
}
