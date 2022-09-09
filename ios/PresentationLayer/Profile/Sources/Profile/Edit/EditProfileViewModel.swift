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
    }
    
    // MARK: Intent
    
    enum Intent {
        case changeFisrtName(String)
        case changeLastName(String)
        case changePhone(String)
        case changeBio(String)
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .changeFisrtName(let fisrtName): changeFirstName(fisrtName)
            case .changeLastName(let lastName): changeLastName(lastName)
            case .changePhone(let phone): changePhone(phone)
            case .changeBio(let bio): changeBio(bio)
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
}
