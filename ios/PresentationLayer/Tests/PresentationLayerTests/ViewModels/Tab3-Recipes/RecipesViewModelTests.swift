//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
@testable import PresentationLayer
import Resolver
import SwiftyMocky
import UseCaseMocks
import XCTest

class RecipesViewModelTests: BaseTestCase {

    // MARK: Tests
    
    func testOpenCounter() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = RecipesViewModel(flowController: fc)
        
        await vm.onIntent(.openRecipe(.counter)).value
        
        XCTAssertEqual(fc.handleFlowValue, .recipes(.showCounter))
    }
    
    func testOpenBooks() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = RecipesViewModel(flowController: fc)
        
        await vm.onIntent(.openRecipe(.books)).value
        
        XCTAssertEqual(fc.handleFlowValue, .recipes(.showBooks))
    }
}
