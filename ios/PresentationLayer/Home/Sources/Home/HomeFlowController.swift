//
//  Created by David Sobíšek on 23.10.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import RaceDetail
import UIKit
import UIToolkit

enum HomeFlow: Flow {
    case home(Home)
    
    enum Home: Equatable {
        case showRaceDetail
    }
}

public final class HomeFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        let vm = HomeViewModel(flowController: self)
        let view = HomeView(viewModel: vm)
        return BaseHostingController(rootView: view)
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let homeFlow = flow as? HomeFlow else { return }
        switch homeFlow {
        case .home(let homeFlow): handleHomeFlow(homeFlow)
        }
    }
}

// MARK: Home flow
extension HomeFlowController {
    func handleHomeFlow(_ flow: HomeFlow.Home) {
        switch flow {
        case .showRaceDetail: showRaceDetail()
        }
    }
    
    private func showRaceDetail() {
        let fc = RaceDetailFlowController(navigationController: navigationController)
        let rootVC = startChildFlow(fc)
        navigationController.tabBarController?.tabBar.isHidden = true
        navigationController.show(rootVC, sender: nil)
    }
}
