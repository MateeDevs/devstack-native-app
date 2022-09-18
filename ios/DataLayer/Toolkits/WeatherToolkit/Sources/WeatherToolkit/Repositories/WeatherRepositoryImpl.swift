//
//  Created by Adam Penaz on 19.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain
import NetworkProvider

public struct WeatherRepositoryImpl: WeatherRepository {
    
    private let network: NetworkProvider
    
    public init(
        networkProvider: NetworkProvider
    ) {
        network = networkProvider
    }

    public func read(cityName: String) async throws -> Weather {
        let endpoint = WeatherAPI.read(cityName)
        let weather = try await network.request(endpoint).map(NETWeather.self).domainModel
        return weather
    }
}
