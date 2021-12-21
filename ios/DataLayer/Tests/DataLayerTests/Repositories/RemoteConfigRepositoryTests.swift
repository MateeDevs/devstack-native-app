//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DataLayer
import ProviderMocks
import RxSwift
import SwiftyMocky
import XCTest

class RemoteConfigRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let remoteConfigProvider = RemoteConfigProviderMock()
    
    private func setupDependencies() -> ProviderDependency {
        Given(remoteConfigProvider, .get(.any, willReturn: .just(true)))
        return ProviderDependencyMock(remoteConfigProvider: remoteConfigProvider)
    }
    
    // MARK: Tests
    
    func testRead() {
        let repository = RemoteConfigRepositoryImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(Bool.self)
        
        repository.read(.profileLabelIsVisible).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(remoteConfigProvider, 1, .get(.any))
    }
}
