//
//  Created by Julia Jakubcova on 02/08/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import KMPShared
import SwiftUI

@MainActor
public extension View {
    @inlinable func bindViewModel<S: VmState, I: VmIntent, E: VmEvent>(
        _ viewModel: BaseViewModel<S, I, E>,
        stateBinding: Binding<S>,
        onEvent: @escaping (E) -> Void
    ) -> some View {
        var eventObservingTask: Task<(), Error>? = nil
        var onFinishStateObserving: (() -> Void)? = nil
        return self
            .onAppear {
                onFinishStateObserving = viewModel.bindState(stateBinding: stateBinding)
                eventObservingTask = Task {
                    for try await newEvent: E in viewModel.asyncStreamFromEvents() {
                        onEvent(newEvent)
                    }
                    eventObservingTask!.cancel()
                }
            }
            .onDisappear {
                viewModel.clear()
                onFinishStateObserving?()
            }
    }
}
