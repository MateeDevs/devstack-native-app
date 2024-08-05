//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DependencyInjection
import Factory
import KMPShared
import SharedDomain
import SwiftUI
import UIToolkit

final class SampleViewModel: UIToolkit.BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.getSampleTextUseCase) private(set) var getSampleTextUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await loadSampleText() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var isLoading: Bool = false
        var sampleText: SampleText? = nil
        var error: String? = nil
        var toast: ToastData?
    }
    
    // MARK: Intent
    enum Intent {
        case onButtonTapped
        case onToastFinished
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .onButtonTapped: showToast(message: "Button was tapped")
            case .onToastFinished: state.toast = nil
            }
        })
    }
    
    // MARK: Private
    
    private func loadSampleText() async {
        do {
            state.isLoading = true
            state.sampleText = try await getSampleTextUseCase.execute()
            state.isLoading = false
        } catch {
            state.error = error.localizedMessage
        }
    }
    
    private func showToast(message: String) {
        state.toast = ToastData(message, hideAfter: 2)
    }
}
