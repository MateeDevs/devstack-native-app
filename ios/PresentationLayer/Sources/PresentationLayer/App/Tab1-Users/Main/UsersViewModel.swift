//
//  Created by Patrik Cesnek on 03.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Resolver
import SwiftUI

extension Flow {
    enum Users {
        case showUserDetailForId(_ userId: String)
    }
}

final class UsersViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies

    private weak var flowController: FlowController?
        
    @Injected private(set) var getUsersUseCase: GetUsersUseCase
    @Injected private(set) var refreshUsersUseCase: RefreshUsersUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        // var page: Int = 0
        var allUsers: [User] = []
        var isRefreshing: Bool = false
        
    }
    
    // MARK: Intent

    enum Intent {
        // Put user data here
        // case pageNumber(Int)
        // case loadUsers(Void)
        // case isRefreshing(Bool)
        case onAppear
        case onRefresh
        case onUserSelected(String)
    }

    func intent(_ intent: Intent) {
        Task {
            switch intent {
                //        case .pageNumber(let page): pageNumber(page)
            case .onAppear: await observeData()
            case .onRefresh: await refreshData()
            case .onUserSelected(let id): onUserSelected(id: id)
            }
        }
    }
    
    // MARK: Private
    
//    private func pageNumber(_ page: Int) {
//        state.page = page
//    }

    private func observeData() async {
        
        do {
            for try await value in getUsersUseCase.execute().values {
                self.state.allUsers = value
            }
        } catch {
            print(error)
        }
    }
    
    private func refreshData() async {
        do {
            _ = try await refreshUsersUseCase.execute(page: 0).asSingle().value
        } catch {}
    }
    
    private func onUserSelected(id: String) {
        flowController?.handleFlow(.users(.showUserDetailForId(id)))
    }
}
