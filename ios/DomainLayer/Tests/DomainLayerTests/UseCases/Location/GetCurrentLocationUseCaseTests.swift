//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import DomainLayer
import RepositoryMocks
import RxSwift
import SwiftyMocky
import XCTest

class GetCurrentLocationUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let location = CLLocation(latitude: 50.0, longitude: 50.0)
    
    private let locationRepository = LocationRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        Given(locationRepository, .getCurrentLocation(
            withAccuracy: .value(kCLLocationAccuracyThreeKilometers),
            willReturn: .just(location)
        ))
        
        return RepositoryDependencyMock(locationRepository: locationRepository)
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetCurrentLocationUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(CLLocation.self)
        
        useCase.execute().bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, location),
            .completed(0)
        ])
        Verify(locationRepository, 1, .getCurrentLocation(withAccuracy: .value(kCLLocationAccuracyThreeKilometers)))
    }
}
