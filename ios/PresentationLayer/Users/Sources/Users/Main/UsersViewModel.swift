//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit
import Utilities

final class UsersViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    private let pagingHandler = PagingHandler<User>()
    private let pageLimit = 10
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.getUsersUseCase) private(set) var getUsersUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
        
        pagingHandler.delegate = AnyPagingHandlerDelegate(self)
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await initData() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var isLoading: Bool = false
        var users: [User] = []
        var isFetchingMore = false
    }
    
    // MARK: Intent
    enum Intent {
        case openUserDetail(id: String)
        case fetchMore
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .openUserDetail(let id): openUserDetail(id)
            case .fetchMore: await fetchMore()
            }
        })
    }
    
    // MARK: Private
    
    private func initData() async {
        do {
            try await pagingHandler.initData()
        } catch {}
    }
    
    private func fetchMore() async {
        do {
            try await pagingHandler.handleBottomTouch(
                originalData: state.users,
                isFetchingMore: state.isFetchingMore
            )
        } catch {}
    }
    
    private func openUserDetail(_ id: String) {
        flowController?.handleFlow(UsersFlow.users(.showUserDetailForId(id)))
    }
}

extension UsersViewModel: PagingHandlerDelegate {
    typealias PagingDataType = User
    
    func fetchData(page: Int) async throws -> Pages<PagingDataType> {
        try await getUsersUseCase.execute(.remote, page: page, limit: pageLimit)
    }
    
    func isFetchingMoreChanged(to isFetchingMore: Bool) {
        state.isFetchingMore = isFetchingMore
    }
    
    func dataUpdated(_ data: [PagingDataType]) {
        state.users = data
    }
}
