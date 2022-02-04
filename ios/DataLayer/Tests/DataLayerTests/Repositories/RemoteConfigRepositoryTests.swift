//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DataLayer
import ProviderMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class RemoteConfigRepositoryTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let remoteConfigProvider = RemoteConfigProviderMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(remoteConfigProvider, .get(.any, willReturn: .just(true)))
        
        Resolver.register { self.remoteConfigProvider as RemoteConfigProvider }
    }
    
    // MARK: Tests
    
    func testRead() {
        let repository = RemoteConfigRepositoryImpl()
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
