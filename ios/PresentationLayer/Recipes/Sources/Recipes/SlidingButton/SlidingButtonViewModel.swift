//
//  Created by David Sobíšek on 18.01.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

final class SlidingButtonViewModel: BaseViewModel, ViewModel, ObservableObject {
    
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
        var isLoadingButton: Bool = false
        var isButtonBlocked: Bool = false
    }
    
    // MARK: Intent
    enum Intent {
        case onButtonSlide
        case onIsLoadingButtonChange(Bool)
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .onButtonSlide: await onButtonSlide()
            case .onIsLoadingButtonChange(let isLoadingButton): onIsLoadingButtonChange(isLoadingButton: isLoadingButton)
            }
        })
    }
    
    // MARK: Private
    
    private func onButtonSlide() async {
        state.isButtonBlocked.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.state.isLoadingButton = false
        }
    }
    
    private func onIsLoadingButtonChange(isLoadingButton: Bool) {
        state.isLoadingButton = isLoadingButton
    }
}
