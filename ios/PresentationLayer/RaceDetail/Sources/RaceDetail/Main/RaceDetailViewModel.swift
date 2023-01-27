//
//  Created by Adam Penaz on 27.01.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import UIToolkit

class RaceDetailViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    init(
        flowController: FlowController?
    ) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task {
            
        })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()
    
    struct State {
        
    }
    
    // MARK: Intent
    enum Intent {
        case onbackButtonTap
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .onbackButtonTap: onBackButtonTap()
            }
        })
    }
    
    // MARK: Private
    
    private func onBackButtonTap() {
        flowController?.handleFlow(RaceDetailFlow.raceDetail(.back))
    }
}
