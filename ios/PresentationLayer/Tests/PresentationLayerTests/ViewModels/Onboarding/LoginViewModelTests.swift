//
//  Created by Petr Chmelar on 07.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
@testable import PresentationLayer
import Resolver
import SwiftyMocky
import UseCaseMocks
import XCTest

class LoginViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let loginUseCase = LoginUseCaseMock()
    private let trackAnalyticsEventUseCase = TrackAnalyticsEventUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Resolver.register { self.loginUseCase as LoginUseCase }
        Resolver.register { self.trackAnalyticsEventUseCase as TrackAnalyticsEventUseCase }
        
        Given(loginUseCase, .execute(
            .value(.stubInvalidPassword),
            willThrow: RepositoryError(statusCode: StatusCode.httpUnathorized, message: "")
        ))
    }

    // MARK: Tests
    
    func testAppear() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = LoginViewModel(flowController: fc)
        
        vm.onAppear()
        
        Verify(trackAnalyticsEventUseCase, 1, .execute(.value(LoginEvent.screenAppear.analyticsEvent)))
    }

    func testLoginEmpty() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = LoginViewModel(flowController: fc)
        
        vm.onIntent(.changeEmail(LoginData.stubEmpty.email))
        vm.onIntent(.changePassword(LoginData.stubEmpty.password))
        await vm.onIntent(.login).value
        
        XCTAssert(!vm.state.loginButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.invalid_credentials))
        XCTAssertEqual(fc.handleFlowValue, nil)
        Verify(loginUseCase, 0, .execute(.any))
        Verify(trackAnalyticsEventUseCase, 0, .execute(.any))
    }
    
    func testLoginValid() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = LoginViewModel(flowController: fc)
        
        vm.onIntent(.changeEmail(LoginData.stubValid.email))
        vm.onIntent(.changePassword(LoginData.stubValid.password))
        await vm.onIntent(.login).value
        
        XCTAssert(vm.state.loginButtonLoading)
        XCTAssertEqual(vm.state.alert, nil)
        XCTAssertEqual(fc.handleFlowValue, .login(.dismiss))
        Verify(loginUseCase, 1, .execute(.value(.stubValid)))
        Verify(trackAnalyticsEventUseCase, 1, .execute(.value(LoginEvent.loginButtonTap.analyticsEvent)))
    }
    
    func testLoginInvalidPassword() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = LoginViewModel(flowController: fc)
        
        vm.onIntent(.changeEmail(LoginData.stubInvalidPassword.email))
        vm.onIntent(.changePassword(LoginData.stubInvalidPassword.password))
        await vm.onIntent(.login).value
        
        XCTAssert(!vm.state.loginButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.invalid_credentials))
        XCTAssertEqual(fc.handleFlowValue, nil)
        Verify(loginUseCase, 1, .execute(.value(.stubInvalidPassword)))
        Verify(trackAnalyticsEventUseCase, 0, .execute(.any))
    }

    func testRegister() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = LoginViewModel(flowController: fc)
        
        await vm.onIntent(.register).value
        
        XCTAssert(!vm.state.loginButtonLoading)
        XCTAssertEqual(vm.state.alert, nil)
        XCTAssertEqual(fc.handleFlowValue, .login(.showRegistration))
        Verify(loginUseCase, 0, .execute(.any))
        Verify(trackAnalyticsEventUseCase, 1, .execute(.value(LoginEvent.registerButtonTap.analyticsEvent)))
    }
}
