//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import UIKit

class BooksFlowController: FlowController {
    
    override func setup() -> UIViewController {
        let vm = BooksViewModel(dependencies: dependencies)
        return BooksViewController.instantiate(fc: self, vm: vm)
    }
    
    override func handleFlow(_ flow: Flow) {
        switch flow {
        case .books(let usersFlow): handleBooksFlow(usersFlow)
        default: ()
        }
    }
}

// MARK: Users flow
extension BooksFlowController {
    func handleBooksFlow(_ flow: Flow.Books) {
        
    }
    
    private func showUserDetailForId(_ userId: String) {
        let vm = UserDetailViewModel(dependencies: dependencies, userId: userId)
        let vc = UserDetailViewController.instantiate(fc: self, vm: vm)
        navigationController.show(vc, sender: nil)
    }
}
