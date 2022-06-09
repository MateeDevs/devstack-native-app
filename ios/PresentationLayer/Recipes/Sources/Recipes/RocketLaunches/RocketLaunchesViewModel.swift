//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import UIToolkit

final class RocketLaunchesViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected private(set) var getRocketLaunchesUseCase: GetRocketLaunchesUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await loadRocketLaunches() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var isLoading: Bool = false
        var rocketLaunches: [RocketLaunch] = []
    }
    
    // MARK: Intent
    enum Intent {
    }

    func onIntent(_ intent: Intent) {}
    
    // MARK: Private
    
    private func loadRocketLaunches() async {
        do {
            state.isLoading = true
            for try await rocketLaunches in getRocketLaunchesUseCase.execute() {
                state.rocketLaunches = rocketLaunches
                state.isLoading = false
            }
        } catch {}
    }
}
