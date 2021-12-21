//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import RxSwift

public protocol HasGetCurrentLocationUseCase {
    var getCurrentLocationUseCase: GetCurrentLocationUseCase { get }
}

public protocol GetCurrentLocationUseCase: AutoMockable {
    func execute() -> Observable<CLLocation>
}

public struct GetCurrentLocationUseCaseImpl: GetCurrentLocationUseCase {
    
    public typealias Dependencies = HasLocationRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> Observable<CLLocation> {
        return dependencies.locationRepository.getCurrentLocation(withAccuracy: kCLLocationAccuracyThreeKilometers)
    }
}
