//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit
import UIToolkit

enum Recipe: String {
    case counter = "Counter"
    case books = "Books"
}

final class RecipesViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: RecipesFlowController?

    init(flowController: RecipesFlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var recipes: [Recipe] = [.counter, .books]
    }
    
    // MARK: Intent
    enum Intent {
        case openRecipe(_ recipe: Recipe)
    }

    @discardableResult
    func onIntent(_ intent: Intent) -> Task<Void, Never> {
        executeTask(Task {
            switch intent {
            case .openRecipe(let recipe): openRecipe(recipe)
            }
        })
    }
    
    // MARK: Private
    
    private func openRecipe(_ recipe: Recipe) {
        switch recipe {
        case .counter:
            flowController?.handleFlow(.recipes(.showCounter))
        case .books:
            flowController?.handleFlow(.recipes(.showBooks))
        }
    }
}
