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
        var saveButtonLoading: Bool = false
        var newFirstName: String = ""
        var newLastName: String = ""
        var newEmail: String = ""
        var newPhone: String = ""
        var newBio: String = ""
    }
    
    // MARK: Intent
    enum Intent {
        case changeFirstName(String)
        case changeLastName(String)
        case changeEmail(String)
        case changePhone(String)
        case changeBio(String)
        case updateUser
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .changeFirstName(let firstName): changeFirstName(firstName)
            case .changeLastName(let lastName): changeLastName(lastName)
            case .changeEmail(let email): changeEmail(email)
            case .changePhone(let phone): changePhone(phone)
            case .changeBio(let bio): changeBio(bio)
            case .updateUser: await updateUser()
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
    
    private func changeFirstName(_ firstName: String) {
        state.newFirstName = firstName
    }
    
    private func changeLastName(_ lastName: String) {
        state.newLastName = lastName
    }
    
    private func changeEmail(_ email: String) {
        state.newEmail = email
    }
    
    private func changePhone(_ phone: String) {
        state.newPhone = phone
    }
    
    private func changeBio(_ bio: String) {
        state.newBio = bio
    }
    
    private func updateUser() async {
        do {
            state.saveButtonLoading = true
            try await updateUserUseCase.execute(.local, user: state.profile!)
        } catch {}
    }
}
