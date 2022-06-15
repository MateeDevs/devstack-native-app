//
//  Created by David Sobisek on 15.06.2022
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
    @Injected private(set) var updateUserUseCase: UpdateUserUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await loadProfile() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var profile: User?
        var name: String = ""
        var email: String = ""
        var password: String = ""
        var bio: String = ""
        var saveButtonLoading: Bool = false
    }
    
    // MARK: Intent
    enum Intent {
        case changeName(String)
        case changeEmail(String)
        case changePassword(String)
        case changeBio(String)
        case updateUser
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .changeName(let name): changeName(name)
            case .changeEmail(let email): changeEmail(email)
            case .changePassword(let password): changePassword(password)
            case .changeBio(let bio): changeBio(bio)
            case .updateUser: updateUser()
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
    
    private func changeName(_ name: String) {
        state.name = name
    }
    
    private func changeEmail(_ email: String) {
        state.email = email
    }
    
    private func changePassword(_ password: String) {
        state.password = password
    }
    
    private func changeBio(_ bio: String) {
        state.bio = bio
    }
    
    private func updateUser() {
        do {
            state.saveButtonLoading = true
            try await updateUserUseCase.execute(.local, user: state.profile)
        } catch {}
    }
}
