//
//  Created by Adam Penaz on 16.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public protocol GetWeatherUseCase {
    func execute(cityName: String) async throws -> Weather
}

public struct GetWeatherUseCaseImpl: GetWeatherUseCase {
    
    private let weatherRepository: WeatherRepository
    
    public init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    public func execute(cityName: String) async throws -> Weather {
        try await weatherRepository.read(cityName: cityName)
    }
}
