//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

public class RecipesFlowController: FlowController {

    override public func setup() -> UIViewController {
        let vm = RecipesViewModel(flowController: self)
        return BaseHostingController(rootView: RecipesView(viewModel: vm))
    }
}

extension RecipesFlowController: FlowHandler {
    public enum Flow: Equatable {
        case recipes(Recipes)
        
        public enum Recipes: Equatable {
            case showCounter
            case showBooks
        }
    }
    
    public func handleFlow(_ flow: Flow) {
        switch flow {
        case .recipes(let recipesFlow): handleRecipesFlow(recipesFlow)
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
