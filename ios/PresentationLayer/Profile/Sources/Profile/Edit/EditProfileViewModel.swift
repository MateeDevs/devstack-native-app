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
        var error: ErrorFields = ErrorFields()
    }
    
    struct ErrorFields {
        var firstName: Bool = false
        var lastName: Bool = false
        var phone: Bool = false
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
        let formatedPhone = formatPhone(phone)
        state.user = User(copy: user, phone: formatedPhone)
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
            state.error = ErrorFields()
            guard let user = state.user else { return }
            try await updateUserUseCase.execute(.remote, user: user)
            flowController?.handleFlow(ProfileFlow.edit(.pop))
        } catch {
            state.saveButtonLoading = false
            state.alert = .init(title: error.localizedDescription)
            guard let validationEditError = error as? ValidationEditError else { return }
            validateFields(validationEditError)
        }
    }
    
    private func dismissAlert() {
        state.alert = nil
    }
    
    private func formatPhone(_ phone: String) -> String {
        var numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let mask = isLongerFormat(phone, numbers) ? "+XXX XXX XXX XXX" : "XXX XXX XXX"
        var result = ""
        
        // iterate over the mask characters until the numbers are left
        for ch in mask where !numbers.isEmpty {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers.removeFirst())
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        result = "\(result)\(numbers)"
        return result
    }
    
    private func isLongerFormat(_ phone: String, _ numbers: String) -> Bool {
        return phone.first == "+" || numbers.count > 9
    }
    
    private func validateFields(_ error: ValidationEditError) {
        switch error {
        case .firstName: state.error.firstName = true
        case .lastName: state.error.lastName = true
        case .phone: state.error.phone = true
        }
    }
}
