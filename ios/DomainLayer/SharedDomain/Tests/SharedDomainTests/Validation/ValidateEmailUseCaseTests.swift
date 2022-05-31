//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain
import XCTest

final class ValidateEmailUseCaseTests: XCTestCase {
    
    // MARK: Tests
    
    func testExecuteEmpty() throws {
        let useCase = ValidateEmailUseCaseImpl()
        
        do {
            try useCase.execute("")
            
            XCTFail("Should throw")
        } catch {
            XCTAssertEqual(error as? ValidationError, .email(.isEmpty))
        }
    }
    
    func testExecuteValid() throws {
        let useCase = ValidateEmailUseCaseImpl()
        
        do {
            try useCase.execute("email@email.com")
            
        } catch {
            XCTFail("Shouldn't throw")
        }
    }
}
