//
//  Created by David Kadlček on 24.07.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Foundation
import UIToolkit
import TipKit

class ExampleTipKitViewModel: BaseViewModel, ObservableObject, ViewModel {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
        
        if #available(iOS 17, *) {
            state.remainingTapsToShowTip = 3 - RuleTip.remainToShow.donations.count
        }
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var remainingTapsToShowTip: Int = 3
    }
    
    // MARK: Intent
    enum Intent {
        case pop
        case tapToShowTip
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .pop: flowController?.pop()
            case .tapToShowTip: await handleTapToShowTip()
            }
        })
    }
    
    private func handleTapToShowTip() async {
        guard #available(iOS 17, *) else { return }
        
        state.remainingTapsToShowTip -= 1
        await RuleTip.remainToShow.donate()
    }
}
