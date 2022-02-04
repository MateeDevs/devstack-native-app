//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import DomainLayer
import DomainStubs
import RepositoryMocks
import Resolver
import RxSwift
import SwiftyMocky
import XCTest

class GetProfileIdUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Given(authTokenRepository, .read(willReturn: AuthToken.stub))
        
        Resolver.register { self.authTokenRepository as AuthTokenRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = GetProfileIdUseCaseImpl()
        
        let output = useCase.execute()
        
        XCTAssertEqual(output, AuthToken.stub.userId)
        Verify(authTokenRepository, 1, .read())
    }
}
