//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import Resolver
import RxSwift

public protocol HasGetCurrentLocationUseCase {
    var getCurrentLocationUseCase: GetCurrentLocationUseCase { get }
}

public protocol GetCurrentLocationUseCase: AutoMockable {
    func execute() -> Observable<CLLocation>
}

public struct GetCurrentLocationUseCaseImpl: GetCurrentLocationUseCase {
    
    @Injected private var locationRepository: LocationRepository
    
    public func execute() -> Observable<CLLocation> {
        locationRepository.getCurrentLocation(withAccuracy: kCLLocationAccuracyThreeKilometers)
    }
}
