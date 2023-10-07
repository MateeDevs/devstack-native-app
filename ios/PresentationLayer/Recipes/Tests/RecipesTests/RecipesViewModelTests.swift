//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@testable import Recipes
import SharedDomain
import UIToolkit
import XCTest

@MainActor
final class RecipesViewModelTests: XCTestCase {
    
    let fc = FlowControllerMock<RecipesFlow>(navigationController: UINavigationController())
    
    private func createViewModel() -> RecipesViewModel {
        return RecipesViewModel(flowController: fc)
    }

    // MARK: Tests
    
    func testOpenCounter() async {
        let vm = createViewModel()
        
        vm.onIntent(.openRecipe(.counter))
        await vm.awaitAllTasks()
        
        XCTAssertEqual(fc.handleFlowValue, .recipes(.showCounter))
    }
    
    func testOpenBooks() async {
        let vm = createViewModel()
        
        vm.onIntent(.openRecipe(.books))
        await vm.awaitAllTasks()
        
        XCTAssertEqual(fc.handleFlowValue, .recipes(.showBooks))
    }
}
