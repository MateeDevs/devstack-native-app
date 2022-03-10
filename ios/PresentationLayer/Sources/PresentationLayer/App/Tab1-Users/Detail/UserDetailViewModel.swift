//
//  Created by Patrik Cesnek on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Resolver
import SwiftUI

final class UserDetailViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies

    private weak var flowController: FlowController?
    private let userId: String
        
    @Injected private(set) var getUserUseCase: GetUserUseCase
    @Injected private(set) var refreshUserUseCase: RefreshUserUseCase
    @Injected private(set) var trackAnalyticsEventUseCase: TrackAnalyticsEventUseCase

    init(
        flowController: FlowController?,
        userId: String
    ) {
        self.flowController = flowController
        self.userId = userId
        super.init()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var user: User?
    }
    
    // MARK: Intent

    enum Intent {
        
        case onAppear
        case onRefresh
    }

    func intent(_ intent: Intent) {
        Task {
            switch intent {
            case .onAppear: await observeData()
            case .onRefresh: await refreshData()
            }
        }
    }
    
    // MARK: Private
    
    private func observeData() async {
        do {
            for try await value in getUserUseCase.execute(id: userId).values {
                self.state.user = value
            }
        } catch {
            print(error)
        }
    }
    
    private func refreshData() async {
        do {
            _ = try await refreshUserUseCase.execute(id: userId).asSingle().value
        } catch {}
    }
}
