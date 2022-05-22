//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Resolver
import SwiftUI

final class UsersViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected private(set) var getUsersUseCase: GetUsersUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await loadUsers() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var users: [User] = []
    }
    
    // MARK: Intent
    enum Intent {
        case openUserDetail(id: String)
    }

    @discardableResult
    func onIntent(_ intent: Intent) -> Task<Void, Never> {
        executeTask(Task {
            switch intent {
            case .openUserDetail(let id): openUserDetail(id)
            }
        })
    }
    
    // MARK: Private
    
    private func loadUsers() async {
        do {
            state.users = try await getUsersUseCase.execute(.local, page: 0)
            state.users = try await getUsersUseCase.execute(.remote, page: 0)
        } catch {}
    }
    
    private func openUserDetail(_ id: String) {
        flowController?.handleFlow(.users(.showUserDetailForId(id)))
    }
}
