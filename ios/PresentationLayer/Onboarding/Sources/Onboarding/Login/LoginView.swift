//
//  Created by Petr Chmelar on 20.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain
import SwiftUI
import UIToolkit
import DevstackKmpShared
import Combine

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    @Injected private var testViewModel: TestViewModel
    
    @State var state: TestViewModel.ViewState
    private var cancellables = [AnyCancellable]()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel

//        let publisher = createPublisher(for: testViewModel.stateXFlow)
//        let cancellable = publisher.sink { completion in
//            print("Received completion: \(completion)")
//        } receiveValue: { value in
//            print("Received value: \(value)")
//            state = value
//        }
        
        
        
    }
    
//    private func observeState() async {
//        try await testViewModel.state.async() { newState in
//            self.state = newState
//        }
//    }
    
    var body: some View {
        VStack {
            Text("\(state.testNumber)")
        
            
            EmailAndPasswordFields(
                title: L10n.login_view_headline_title,
                email: viewModel.state.email,
                password: viewModel.state.password,
                onEmailChange: { email in viewModel.onIntent(.changeEmail(email)) },
                onPasswordChange: { password in viewModel.onIntent(.changePassword(password)) }
            )
            Spacer()
            InfoErrorSnackHost(snackState: viewModel.snackState)
            PrimaryAndSecondaryButtons(
                primaryButtonTitle: L10n.login_view_login_button_title,
                onPrimaryButtonTap: { viewModel.onIntent(.login) },
                secondaryButtonTitle: L10n.login_view_register_button_title,
                onSecondaryButtonTap: { viewModel.onIntent(.register) }
            )
        }
        .animation(.default)
        .environment(\.isLoading, viewModel.state.isLoading)
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.onIntent(.dismissAlert) }
        )) { alert in .init(alert) }
        .lifecycle(viewModel)
        .onAppear {
            testViewModel.onIntent(intent: TestViewModelViewIntentOnViewAppeared())
        }
        .onDisappear {
            testViewModel.onCleared()
            cancellables.forEach { $0.cancel() }
            cancellables.removeAll()
        }
    }
}

#if DEBUG
import Resolver
import SharedDomainMocks
import Utilities

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Environment.locale = .init(identifier: "cs")
        Resolver.registerUseCaseMocks()
        
        let vm = LoginViewModel(flowController: nil)
        return PreviewGroup {
            LoginView(viewModel: vm)
        }
    }
}
#endif
