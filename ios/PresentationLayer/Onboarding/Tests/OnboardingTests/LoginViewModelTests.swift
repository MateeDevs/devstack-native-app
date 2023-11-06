//
//  Created by Petr Chmelar on 07.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@testable import Onboarding
import Resolver
@testable import SharedDomain
import UIToolkit
import XCTest
import Combine

@MainActor
final class LoginViewModelTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let fc = FlowControllerMock<OnboardingFlow>(navigationController: UINavigationController())
    
    private var disposeBag = Set<AnyCancellable>()
    
    private let loginUseCase = LoginUseCaseSpy()
    private let trackAnalyticsEventUseCase = TrackAnalyticsEventUseCaseSpy()
    
    private func createViewModel() -> LoginViewModel {
        Resolver.register { self.loginUseCase as LoginUseCase }
        Resolver.register { self.trackAnalyticsEventUseCase as TrackAnalyticsEventUseCase }
        
        let vm = LoginViewModel(flowController: fc)
        observeSnackState(vm: vm)
        
        return vm
    }
    
    private func observeSnackState(vm: LoginViewModel) {
        vm.snackState.$currentData.sink { snackState in
            if let snackState {
                snackState.dismiss()
            }
        }
        .store(in: &disposeBag)
    }

    // MARK: Tests
    
    func testAppear() async {
        let vm = createViewModel()
        
        vm.onAppear()
        
        XCTAssert(trackAnalyticsEventUseCase.executeReceivedInvocations == [LoginEvent.screenAppear.analyticsEvent])
    }

    func testLoginEmptyEmail() async {
        let vm = createViewModel()
        loginUseCase.executeThrowableError = ValidationError.email(.isEmpty)
        
        vm.onIntent(.changeEmail(LoginData.stubEmptyEmail.email))
        vm.onIntent(.changePassword(LoginData.stubEmptyEmail.password))
        vm.onIntent(.login)
        await vm.awaitAllTasks()
        
        XCTAssert(!vm.state.isLoading)
        XCTAssertEqual(fc.handleFlowValue, nil)
        XCTAssert(loginUseCase.executeReceivedInvocations == [.stubEmptyEmail])
        XCTAssertEqual(trackAnalyticsEventUseCase.executeCallsCount, 0)
    }
    
    func testLoginEmptyPassword() async {
        let vm = createViewModel()
        loginUseCase.executeThrowableError = ValidationError.password(.isEmpty)
        
        vm.onIntent(.changeEmail(LoginData.stubEmptyPassword.email))
        vm.onIntent(.changePassword(LoginData.stubEmptyPassword.password))
        vm.onIntent(.login)
        await vm.awaitAllTasks()
        
        XCTAssert(!vm.state.isLoading)
        XCTAssertEqual(fc.handleFlowValue, nil)
        XCTAssert(loginUseCase.executeReceivedInvocations == [.stubEmptyPassword])
        XCTAssertEqual(trackAnalyticsEventUseCase.executeCallsCount, 0)
    }
    
    func testLoginValid() async {
        let vm = createViewModel()
        
        vm.onIntent(.changeEmail(LoginData.stubValid.email))
        vm.onIntent(.changePassword(LoginData.stubValid.password))
        vm.onIntent(.login)
        await vm.awaitAllTasks()
        
        XCTAssert(vm.state.isLoading)
        XCTAssertEqual(vm.state.alert, nil)
        XCTAssertEqual(fc.handleFlowValue, .login(.dismiss))
        XCTAssert(loginUseCase.executeReceivedInvocations == [.stubValid])
        XCTAssert(trackAnalyticsEventUseCase.executeReceivedInvocations == [LoginEvent.loginButtonTap.analyticsEvent])
    }
    
    func testLoginInvalidPassword() async {
        let vm = createViewModel()
        loginUseCase.executeThrowableError = AuthError.login(.invalidCredentials)
        
        vm.onIntent(.changeEmail(LoginData.stubValid.email))
        vm.onIntent(.changePassword(LoginData.stubValid.password))
        vm.onIntent(.login)
        await vm.awaitAllTasks()
        
        XCTAssert(!vm.state.isLoading)
        XCTAssertEqual(fc.handleFlowValue, nil)
        XCTAssert(loginUseCase.executeReceivedInvocations == [.stubValid])
        XCTAssertEqual(trackAnalyticsEventUseCase.executeCallsCount, 0)
    }

    func testRegister() async {
        let vm = createViewModel()
        
        vm.onIntent(.register)
        await vm.awaitAllTasks()
        
        XCTAssert(!vm.state.isLoading)
        XCTAssertEqual(vm.state.alert, nil)
        XCTAssertEqual(fc.handleFlowValue, .login(.showRegistration))
        XCTAssertEqual(loginUseCase.executeCallsCount, 0)
        XCTAssert(trackAnalyticsEventUseCase.executeReceivedInvocations == [LoginEvent.registerButtonTap.analyticsEvent])
    }
}
