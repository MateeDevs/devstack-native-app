//
//  Created by David Sobíšek on 23.10.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import UIKit
import UIToolkit

enum RaceDetailFlow: Flow {
    case raceDetail(RaceDetail)
    
    enum RaceDetail: Equatable {
        case back
    }
}

public final class RaceDetailFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        let vm = RaceDetailViewModel(flowController: self)
        let view = RaceDetailView(viewModel: vm)
        return BaseHostingController(rootView: view)
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let raceDetailFlow = flow as? RaceDetailFlow else { return }
        switch raceDetailFlow {
        case .raceDetail(let raceDetailFlow): handleRaceDetailFlow(raceDetailFlow)
        }
    }
}

// MARK: RaceDetail flow
extension RaceDetailFlowController {
    func handleRaceDetailFlow(_ flow: RaceDetailFlow.RaceDetail) {
        switch flow {
        case .back: back()
        }
    }
    
    private func back() {
        navigationController.tabBarController?.tabBar.isHidden = false
        pop()
    }
}
