//
//  Created by Petr Chmelar on 07.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@testable import Onboarding
import Resolver
import SharedDomain
import SharedDomainMocks
import UIToolkit
import XCTest

@MainActor
class LoginViewModelTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let fc = OnboardingFlowController(navigationController: UINavigationController())
    
    private let loginUseCase = LoginUseCaseMock()
    private let trackAnalyticsEventUseCase = TrackAnalyticsEventUseCaseMock()
    
    private func createViewModel() -> LoginViewModel {
        Resolver.register { self.loginUseCase as LoginUseCase }
        Resolver.register { self.trackAnalyticsEventUseCase as TrackAnalyticsEventUseCase }
        
        return LoginViewModel(flowController: fc)
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
        await vm.onIntent(.login).value
        
        XCTAssert(!vm.state.loginButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.invalid_email))
        // XCTAssertEqual(fc.handleFlowValue, nil)
        XCTAssert(loginUseCase.executeReceivedInvocations == [.stubEmptyEmail])
        XCTAssertEqual(trackAnalyticsEventUseCase.executeCallsCount, 0)
    }
    
    func testLoginEmptyPassword() async {
        let vm = createViewModel()
        loginUseCase.executeThrowableError = ValidationError.password(.isEmpty)
        
        vm.onIntent(.changeEmail(LoginData.stubEmptyPassword.email))
        vm.onIntent(.changePassword(LoginData.stubEmptyPassword.password))
        await vm.onIntent(.login).value
        
        XCTAssert(!vm.state.loginButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.invalid_password))
        // XCTAssertEqual(fc.handleFlowValue, nil)
        XCTAssert(loginUseCase.executeReceivedInvocations == [.stubEmptyPassword])
        XCTAssertEqual(trackAnalyticsEventUseCase.executeCallsCount, 0)
    }
    
    func testLoginValid() async {
        let vm = createViewModel()
        
        vm.onIntent(.changeEmail(LoginData.stubValid.email))
        vm.onIntent(.changePassword(LoginData.stubValid.password))
        await vm.onIntent(.login).value
        
        XCTAssert(vm.state.loginButtonLoading)
        XCTAssertEqual(vm.state.alert, nil)
        // XCTAssertEqual(fc.handleFlowValue, .login(.dismiss))
        XCTAssert(loginUseCase.executeReceivedInvocations == [.stubValid])
        XCTAssert(trackAnalyticsEventUseCase.executeReceivedInvocations == [LoginEvent.loginButtonTap.analyticsEvent])
    }
    
    func testLoginInvalidPassword() async {
        let vm = createViewModel()
        loginUseCase.executeThrowableError = AuthError.login(.invalidCredentials)
        
        vm.onIntent(.changeEmail(LoginData.stubValid.email))
        vm.onIntent(.changePassword(LoginData.stubValid.password))
        await vm.onIntent(.login).value
        
        XCTAssert(!vm.state.loginButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.invalid_credentials))
        // XCTAssertEqual(fc.handleFlowValue, nil)
        XCTAssert(loginUseCase.executeReceivedInvocations == [.stubValid])
        XCTAssertEqual(trackAnalyticsEventUseCase.executeCallsCount, 0)
    }

    func testRegister() async {
        let vm = createViewModel()
        
        await vm.onIntent(.register).value
        
        XCTAssert(!vm.state.loginButtonLoading)
        XCTAssertEqual(vm.state.alert, nil)
        // XCTAssertEqual(fc.handleFlowValue, .login(.showRegistration))
        XCTAssertEqual(loginUseCase.executeCallsCount, 0)
        XCTAssert(trackAnalyticsEventUseCase.executeReceivedInvocations == [LoginEvent.registerButtonTap.analyticsEvent])
    }
}
