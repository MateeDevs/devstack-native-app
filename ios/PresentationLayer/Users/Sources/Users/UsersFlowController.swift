//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

public class UsersFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        let vm = UsersViewModel(flowController: self)
        return BaseHostingController(rootView: UsersView(viewModel: vm))
    }
}

extension UsersFlowController: FlowHandler {
    public enum Flow: Equatable {
        case users(Users)
        
        public enum Users: Equatable {
            case showUserDetailForId(_ userId: String)
        }
    }
    
    public func handleFlow(_ flow: Flow) {
        switch flow {
        case .users(let usersFlow): handleUsersFlow(usersFlow)
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
        let vm = UserDetailViewModel(userId: userId, flowController: self)
        let vc = BaseHostingController(rootView: UserDetailView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
}
