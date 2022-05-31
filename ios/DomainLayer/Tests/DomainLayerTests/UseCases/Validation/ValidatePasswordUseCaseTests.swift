//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import SwiftyMocky
import XCTest

class ValidatePasswordUseCaseTests: BaseTestCase {
    
    // MARK: Tests
    
    func testExecuteEmpty() throws {
        let useCase = ValidatePasswordUseCaseImpl()
        
        do {
            try useCase.execute("")
            XCTFail("Should throw")
        } catch {
            XCTAssertEqual(error as? ValidationError, .password(.isEmpty))
        }
    }
    
    func testExecuteValid() throws {
        let useCase = ValidatePasswordUseCaseImpl()
        
        do {
            try useCase.execute("password")
        } catch {
            XCTFail("Shouldn't throw")
        }
    }
}
