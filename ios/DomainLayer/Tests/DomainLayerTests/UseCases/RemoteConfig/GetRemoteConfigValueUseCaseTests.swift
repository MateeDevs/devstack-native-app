//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RepositoryMocks
import RxSwift
import SwiftyMocky
import XCTest

class GetRemoteConfigValueUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let remoteConfigRepository = RemoteConfigRepositoryMock()
    
    private func setupDependencies() -> RepositoryDependency {
        Given(remoteConfigRepository, .read(.value(.profileLabelIsVisible), willReturn: .just(true)))
        return RepositoryDependencyMock(remoteConfigRepository: remoteConfigRepository)
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetRemoteConfigValueUseCaseImpl(dependencies: setupDependencies())
        let output = scheduler.createObserver(Bool.self)
        
        useCase.execute(.profileLabelIsVisible).bind(to: output).disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(output.events, [
            .next(0, true),
            .completed(0)
        ])
        Verify(remoteConfigRepository, 1, .read(.value(.profileLabelIsVisible)))
    }
}
