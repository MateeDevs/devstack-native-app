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

class LogoutUseCaseTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let authTokenRepository = AuthTokenRepositoryMock()
    
    override func registerDependencies() {
        super.registerDependencies()
        
        Resolver.register { self.authTokenRepository as AuthTokenRepository }
    }
    
    // MARK: Tests

    func testExecute() {
        let useCase = LogoutUseCaseImpl()
        
        useCase.execute()
        
        Verify(authTokenRepository, 1, .delete())
    }
}
