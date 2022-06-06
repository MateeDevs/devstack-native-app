//
//  Created by Petr Chmelar on 07.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

final class SkeletonViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await loadTitle() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var title: String?
    }
    
    // MARK: Intent
    enum Intent {
    }

    func onIntent(_ intent: Intent) {}
    
    // MARK: Private
    
    private func loadTitle() async {
        do {
            try await Task.sleep(nanoseconds: 3000000000)
            state.title = "Some title"
        } catch {}
    }
}
