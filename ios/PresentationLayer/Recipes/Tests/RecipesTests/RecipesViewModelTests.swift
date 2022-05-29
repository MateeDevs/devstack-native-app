//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@testable import Recipes
import Resolver
import SharedDomain
import SharedDomainMocks
import XCTest

@MainActor
class RecipesViewModelTests: XCTestCase {
    
    let fc = RecipesFlowController(navigationController: UINavigationController())
    
    private func createViewModel() -> RecipesViewModel {
        return RecipesViewModel(flowController: fc)
    }

    // MARK: Tests
    
    func testOpenCounter() async {
        let vm = createViewModel()
        
        await vm.onIntent(.openRecipe(.counter)).value
        
        // XCTAssertEqual(fc.handleFlowValue, .recipes(.showCounter))
    }
    
    func testOpenBooks() async {
        let vm = createViewModel()
        
        await vm.onIntent(.openRecipe(.books)).value
        
        // XCTAssertEqual(fc.handleFlowValue, .recipes(.showBooks))
    }
}
