//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import UIToolkit

final class ProfileViewModel: BaseViewModel, ViewModel, ObservableObject {
    
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
        super.onAppear()
        executeTask(Task { await loadProfile() })
        executeTask(Task { await loadCurrentLocation() })
        executeTask(Task { await loadRemoteConfig() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var profile: User?
        var currentLocation: String = "..."
        var remoteConfigLabelIsVisible: Bool = true
    }
    
    // MARK: Intent
    enum Intent {
        case registerForPushNotifications
        case editProfile
        case logout
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .registerForPushNotifications: registerForPushNotifications()
            case .editProfile: editProfile()
            case .logout: logout()
            }
        })
    }
    
    // MARK: Private
    
    private func loadProfile() async {
        do {
            state.profile = try await getProfileUseCase.execute(.local)
            state.profile = try await getProfileUseCase.execute(.remote)
        } catch {}
    }
    
    private func loadCurrentLocation() async {
        for try await currentLocation in getCurrentLocationUseCase.execute() {
            state.currentLocation = currentLocation.coordinate.toString()
        }
    }
    
    private func loadRemoteConfig() async {
        do {
            let visible = try await getRemoteConfigValueUseCase.execute(.profileLabelIsVisible)
            state.remoteConfigLabelIsVisible = visible
        } catch {}
    }
    
    private func registerForPushNotifications() {
        registerForPushNotificationsUseCase.execute(
            options: [.alert, .badge, .sound],
            completionHandler: { _, _ in }
        )
    }
    
    private func editProfile() {
        // flow
    }
    
    private func logout() {
        do {
            try logoutUseCase.execute()
        } catch {}
        flowController?.handleFlow(ProfileFlow.profile(.presentOnboarding))
    }
}
