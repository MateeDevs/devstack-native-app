//
//  Created by Petr Chmelar on 24.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@testable import SharedDomain
import XCTest

final class IsUserLoggedUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let getProfileIdUseCase = GetProfileIdUseCaseSpy()
    
    // MARK: Tests
    
    func testExecute() {
        let useCase = IsUserLoggedUseCaseImpl(getProfileIdUseCase: getProfileIdUseCase)
        getProfileIdUseCase.executeReturnValue = AuthToken.stub.userId
        
        let isLogged = useCase.execute()
        
        XCTAssertEqual(isLogged, true)
        XCTAssertEqual(getProfileIdUseCase.executeCallsCount, 1)
    }
}
