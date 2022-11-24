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
    private weak var flowController: FlowController?
    
    @Injected private(set) var getProfileUseCase: GetProfileUseCase
    @Injected private(set) var updateProfileCounterUseCase: UpdateProfileCounterUseCase

    init(flowController: FlowController?) {
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
        var toastData: ToastData?
    }
    
    // MARK: Intent
    enum Intent {
        case increase
        case decrease
        case dismissToast
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .increase: await updateValue(state.value + 1)
            case .decrease: await updateValue(state.value - 1)
            case .dismissToast: dismissToast()
            }
        })
    }
    
    // MARK: Private
    
    private func loadValue() async {
        do {
            state.value = try await getProfileUseCase.execute(.local).counter
            state.toastData = .init(L10n.counter_view_load_toast_message, style: .info, hideAfter: 2.5)
        } catch {}
    }
    
    private func updateValue(_ value: Int) async {
        do {
            try await updateProfileCounterUseCase.execute(value: value)
            state.toastData = .init(
                value > state.value
                    ? L10n.counter_view_increased_toast_message
                    : L10n.counter_view_decreased_toast_message,
                style: value > state.value ? .success : .error,
                hideAfter: 2.5
            )
            state.value = value
        } catch {}
    }
    
    private func dismissToast() {
        state.toastData = nil
    }
}
