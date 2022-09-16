//
//  Created by Adam Penaz on 16.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public protocol WeatherRepository {
    func read(cityName: String) async throws -> Weather
}
