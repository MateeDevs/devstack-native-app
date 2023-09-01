//
//  Created by Petr Chmelar on 03.08.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

final class MapsViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
    }
    
    // MARK: Intent
    enum Intent {
    }

    func onIntent(_ intent: Intent) {}
    
    // MARK: Private
}
