//
//  Created by Adam Penaz on 19.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import NetworkProvider
import Utilities

enum WeatherAPI {
    case read(_ cityName: String, _ units: WeatherUnitsAPI = .celsius )
}

enum WeatherUnitsAPI: String {
    case kelvin = "standard"
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension WeatherAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: "\(NetworkingConstants.weatherURL)")! }
    var path: String {
        return ""
    }
    var method: NetworkMethod {
        return .get
    }
    var headers: [String: String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case let .read(cityName, units):
            let params: [String: Any] = [
                "appid": "01158424c8755e2176088f6467343125",
                "units": units.rawValue,
                "q": cityName
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
