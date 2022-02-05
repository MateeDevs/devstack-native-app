//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import RxSwift

public protocol GetCurrentLocationUseCase: AutoMockable {
    func execute() -> Observable<CLLocation>
}

public struct GetCurrentLocationUseCaseImpl: GetCurrentLocationUseCase {
    
    private let locationRepository: LocationRepository
    
    public init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }
    
    public func execute() -> Observable<CLLocation> {
        locationRepository.getCurrentLocation(withAccuracy: kCLLocationAccuracyThreeKilometers)
    }
}
