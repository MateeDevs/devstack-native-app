//
//  Created by Petr Chmelar on 30.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class LogoutUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositorySpy()
    
    // MARK: Tests

    func testExecute() throws {
        let useCase = LogoutUseCaseImpl(authRepository: authRepository)
        
        try useCase.execute()
        
        XCTAssertEqual(authRepository.logoutCallsCount, 1)
    }
}
