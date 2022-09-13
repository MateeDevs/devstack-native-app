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
    @Injected private(set) var updateUserUseCase: UpdateUserUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await loadUser() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var user: User?
        var alert: AlertData?
        var saveButtonLoading: Bool = false
    }
    
    // MARK: Intent
    
    enum Intent {
        case changeFirstName(String)
        case changeLastName(String)
        case changePhone(String)
        case changeBio(String)
        case save
        case dismissAlert
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .changeFirstName(let fisrtName): changeFirstName(fisrtName)
            case .changeLastName(let lastName): changeLastName(lastName)
            case .changePhone(let phone): changePhone(phone)
            case .changeBio(let bio): changeBio(bio)
            case .save: await save()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: Private
    
    private func changeFirstName(_ firstName: String) {
        guard let user = state.user else { return }
        state.user = User(copy: user, firstName: firstName)
    }
    
    private func changeLastName(_ lastName: String) {
        guard let user = state.user else { return }
        state.user = User(copy: user, lastName: lastName)
    }
    
    private func changePhone(_ phone: String) {
        guard let user = state.user else { return }
        state.user = User(copy: user, phone: phone)
    }
    
    private func changeBio(_ bio: String) {
        guard let user = state.user else { return }
        state.user = User(copy: user, bio: bio)
    }
    
    private func loadUser() async {
        do {
            state.user = try await getProfileUseCase.execute(.local)
            state.user = try await getProfileUseCase.execute(.remote)
        } catch {}
    }
    
    private func save() async {
        do {
            state.saveButtonLoading = true
            guard let user = state.user else { return }
            try await updateUserUseCase.execute(.remote, user: user)
            flowController?.handleFlow(ProfileFlow.edit(.pop))
        } catch {
            state.saveButtonLoading = false
            state.alert = .init(title: error.localizedDescription)
        }
    }
    
    private func dismissAlert() {
        state.alert = nil
    }
}
