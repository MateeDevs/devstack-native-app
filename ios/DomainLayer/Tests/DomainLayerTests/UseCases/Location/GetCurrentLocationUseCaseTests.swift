//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
@testable import DomainLayer
import RepositoryMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class GetCurrentLocationUseCaseTests: BaseTestCase {
    
    private let location = CLLocation(latitude: 50.0, longitude: 50.0)
    
    // MARK: Dependencies
    
    private let locationRepository = LocationRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(locationRepository, .getCurrentLocation(
            withAccuracy: .value(kCLLocationAccuracyThreeKilometers),
            willReturn: .just(location)
        ))
        
        Resolver.register { self.locationRepository as LocationRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetCurrentLocationUseCaseImpl()
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
