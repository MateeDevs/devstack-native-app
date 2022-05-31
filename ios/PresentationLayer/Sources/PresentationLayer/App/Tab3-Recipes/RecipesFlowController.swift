//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import SwiftUI
import UIKit

extension Flow {
    enum Recipes: Equatable {
        case showCounter
        case showBooks
    }
}

class RecipesFlowController: FlowController {

    override func setup() -> UIViewController {
        let vm = RecipesViewModel(flowController: self)
        return BaseHostingController(rootView: RecipesView(viewModel: vm))
    }
    
    override func handleFlow(_ flow: Flow) {
        switch flow {
        case .recipes(let recipesFlow): handleRecipesFlow(recipesFlow)
        default: ()
        }
    }
}

// MARK: Recipes flow
extension RecipesFlowController {
    func handleRecipesFlow(_ flow: Flow.Recipes) {
        switch flow {
        case .showCounter: showCounter()
        case .showBooks: showBooks()
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
}
