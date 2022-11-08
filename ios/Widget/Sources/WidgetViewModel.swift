//
//  Created by Tomas Brand on 14.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import UIToolkit

final class WidgetViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: - Private properties
    
    @Injected private(set) var getUserUseCase: GetProfileUseCase
    
    // MARK: - Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await getUser() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var user: User?
        var viewData: UserWidgetViewData?
    }
    
    // MARK: Intent
    
    enum Intent {}
    
    func onIntent(_ intent: Intent) {}
    
    // MARK: - Private methods
    
    private func getUser() async {
        do {
            state.user = try await getUserUseCase.execute(.remote)
           // guard let name = state.user?.firstName else { return }
           // state.viewData = .user(UserWidgetViewData.UserData(name: name, pictureUrl: ""))
        } catch {
            print(error.localizedDescription)
        }
    }
}

enum UserWidgetViewData: Equatable {
    struct UserData: Equatable {
        let name: String
        let pictureUrl: String
    }

    case user(UserData)
    case noData
}
