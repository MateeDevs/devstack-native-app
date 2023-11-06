//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import Spyable

@Spyable
public protocol GetCurrentLocationUseCase {
    func execute() -> AsyncStream<CLLocation>
}

public struct GetCurrentLocationUseCaseImpl: GetCurrentLocationUseCase {
    
    private let locationRepository: LocationRepository
    
    public init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }
    
    public func execute() -> AsyncStream<CLLocation> {
        locationRepository.readCurrentLocation(withAccuracy: kCLLocationAccuracyThreeKilometers)
    }
}
