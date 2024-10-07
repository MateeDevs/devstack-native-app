//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

enum Recipe: String, CaseIterable {
    case counter = "Counter"
    case books = "Books"
    case rocketLaunches = "RocketLaunches"
    case skeleton = "Skeleton"
    case images = "Images"
    case maps = "Maps"
    case slidingButton = "SlidingButton"
    case tipKit = "TipKit"
    case media = "Media"
}

final class RecipesViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var recipes: [Recipe] = Recipe.allCases
    }
    
    // MARK: Intent
    enum Intent {
        case openRecipe(_ recipe: Recipe)
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .openRecipe(let recipe): openRecipe(recipe)
            }
        })
    }
    
    // MARK: Private
    
    private func openRecipe(_ recipe: Recipe) {
        switch recipe {
        case .counter: flowController?.handleFlow(RecipesFlow.recipes(.showCounter))
        case .books: flowController?.handleFlow(RecipesFlow.recipes(.showBooks))
        case .rocketLaunches: flowController?.handleFlow(RecipesFlow.recipes(.showRocketLaunches))
        case .skeleton: flowController?.handleFlow(RecipesFlow.recipes(.showSkeleton))
        case .images: flowController?.handleFlow(RecipesFlow.recipes(.showImages))
        case .maps: flowController?.handleFlow(RecipesFlow.recipes(.showMaps))
        case .slidingButton: flowController?.handleFlow(RecipesFlow.recipes(.showSlidingButton))
        case .tipKit: flowController?.handleFlow(RecipesFlow.recipes(.showTipKitExample))
        case .media: flowController?.handleFlow(RecipesFlow.recipes(.showMedia))
        }
    }
}
