//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

class UsersFlowController: FlowController {
    
    override func setup() -> UIViewController {
        let vm = UsersViewModel(dependencies: dependencies)
        return UsersViewController.instantiate(fc: self, vm: vm)
    }
    
    override func handleFlow(_ flow: Flow) {
        switch flow {
        case .users(let usersFlow): handleUsersFlow(usersFlow)
        default: ()
        }
    }
}

// MARK: Users flow
extension UsersFlowController {
    func handleUsersFlow(_ flow: Flow.Users) {
        switch flow {
        case .showUserDetailForId(let userId): showUserDetailForId(userId)
        }
    }
    
    private func showUserDetailForId(_ userId: String) {
        let vm = UserDetailViewModel(dependencies: dependencies, userId: userId)
        let vc = UserDetailViewController.instantiate(fc: self, vm: vm)
        navigationController.show(vc, sender: nil)
    }
}
