//
//  Created by Adam Penaz on 19.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import NetworkProvider
import SharedDomain

public struct WeatherRepositoryImpl: WeatherRepository {
    
    private let network: NetworkProvider
    
    public init(
        networkProvider: NetworkProvider
    ) {
        network = networkProvider
    }

    public func read(cityName: String, units: WeatherUnits) async throws -> Weather {
        let endpoint = WeatherAPI.read(cityName, units.networkModel)
        let weather = try await network.request(endpoint).map(NETWeather.self).domainModel(units: units)
        return weather
    }
}
