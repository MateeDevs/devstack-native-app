//
//  Created by David Sobíšek on 23.10.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import UIKit
import UIToolkit

enum ProfileFlow: Flow {
    case profile(Profile)
    
    enum Profile: Equatable {
        
    }
}

public final class ProfileFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        let view = ProfileView()
        return BaseHostingController(rootView: view)
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let profileFlow = flow as? ProfileFlow else { return }
        switch profileFlow {
        
        }
    }
}

// MARK: Profile flow
extension ProfileFlowController {
    func handleProfileFlow(_ flow: ProfileFlow.Profile) {
        switch flow {
        
        }
    }
}
