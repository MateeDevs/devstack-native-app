//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

enum RecipesFlow: Flow, Equatable {
    case recipes(Recipes)
    
    enum Recipes: Equatable {
        case showCounter
        case showBooks
        case showRocketLaunches
    }
}

public final class RecipesFlowController: FlowController {

    override public func setup() -> UIViewController {
        let vm = RecipesViewModel(flowController: self)
        return BaseHostingController(rootView: RecipesView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let recipesFlow = flow as? RecipesFlow else { return }
        switch recipesFlow {
        case .recipes(let recipesFlow): handleRecipesFlow(recipesFlow)
        }
    }
}

// MARK: Recipes flow
extension RecipesFlowController {
    func handleRecipesFlow(_ flow: RecipesFlow.Recipes) {
        switch flow {
        case .showCounter: showCounter()
        case .showBooks: showBooks()
        case .showRocketLaunches: showRocketLaunches()
        }
    }
    
    private func showCounter() {
        let vm = CounterViewModel(flowController: self)
        let vc = BaseHostingController(rootView: CounterView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showBooks() {
        let vm = BooksViewModel(flowController: self)
        let vc = BaseHostingController(rootView: BooksView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showRocketLaunches() {
        let vm = RocketLaunchesViewModel(flowController: self)
        let vc = BaseHostingController(rootView: RocketLaunchesView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
}
