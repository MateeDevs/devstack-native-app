//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DomainLayer
import RepositoryMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class GetRemoteConfigValueUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let remoteConfigRepository = RemoteConfigRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(remoteConfigRepository, .read(.value(.profileLabelIsVisible), willReturn: .just(true)))
        
        Resolver.register { self.remoteConfigRepository as RemoteConfigRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetRemoteConfigValueUseCaseImpl()
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
