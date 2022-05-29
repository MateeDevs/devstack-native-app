//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import UIToolkit

final class CounterViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: RecipesFlowController?
    
    @Injected private(set) var getProfileUseCase: GetProfileUseCase
    @Injected private(set) var updateProfileCounterUseCase: UpdateProfileCounterUseCase

    init(flowController: RecipesFlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await loadValue() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var value: Int = 0
    }
    
    // MARK: Intent
    enum Intent {
        case increase
        case decrease
    }

    @discardableResult
    func onIntent(_ intent: Intent) -> Task<Void, Never> {
        executeTask(Task {
            switch intent {
            case .increase: await updateValue(state.value + 1)
            case .decrease: await updateValue(state.value - 1)
            }
        })
    }
    
    // MARK: Private
    
    private func loadValue() async {
        do {
            state.value = try await getProfileUseCase.execute(.local).counter
        } catch {}
    }
    
    private func updateValue(_ value: Int) async {
        do {
            try await updateProfileCounterUseCase.execute(value: value)
            state.value = value
        } catch {}
    }
}
