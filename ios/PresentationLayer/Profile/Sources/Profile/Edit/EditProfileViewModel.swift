//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import UIToolkit

final class EditProfileViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected private(set) var getProfileUseCase: GetProfileUseCase
    @Injected private(set) var getCurrentLocationUseCase: GetCurrentLocationUseCase
    @Injected private(set) var getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase
    @Injected private(set) var registerForPushNotificationsUseCase: RegisterForPushNotificationsUseCase
    @Injected private(set) var logoutUseCase: LogoutUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        
    }
    
    // MARK: Intent
    enum Intent {
        
    }

    func onIntent(_ intent: Intent) {
        
    }
    
    // MARK: Private
    
}
