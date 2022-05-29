//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

@testable import Onboarding
import Resolver
import SharedDomain
import SharedDomainMocks
import UIToolkit
import XCTest

@MainActor
class RegistrationViewModelTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let fc = OnboardingFlowController(navigationController: UINavigationController())
    
    private let registrationUseCase = RegistrationUseCaseMock()
    
    private func createViewModel() -> RegistrationViewModel {
        Resolver.register { self.registrationUseCase as RegistrationUseCase }
        
        return RegistrationViewModel(flowController: fc)
    }

    // MARK: Tests

    func testRegisterEmptyEmail() async {
        let vm = createViewModel()
        registrationUseCase.executeThrowableError = ValidationError.email(.isEmpty)
        
        vm.onIntent(.changeEmail(RegistrationData.stubEmptyEmail.email))
        vm.onIntent(.changePassword(RegistrationData.stubEmptyEmail.password))
        await vm.onIntent(.register).value
        
        XCTAssert(!vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.invalid_email))
        // XCTAssertEqual(fc.handleFlowValue, nil)
        XCTAssert(registrationUseCase.executeReceivedInvocations == [.stubEmptyEmail])
    }
    
    func testRegisterEmptyPassword() async {
        let vm = createViewModel()
        registrationUseCase.executeThrowableError = ValidationError.password(.isEmpty)
        
        vm.onIntent(.changeEmail(RegistrationData.stubEmptyPassword.email))
        vm.onIntent(.changePassword(RegistrationData.stubEmptyPassword.password))
        await vm.onIntent(.register).value
        
        XCTAssert(!vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.invalid_password))
        // XCTAssertEqual(fc.handleFlowValue, nil)
        XCTAssert(registrationUseCase.executeReceivedInvocations == [.stubEmptyPassword])
    }
    
    func testRegisterValid() async {
        let vm = createViewModel()
        
        vm.onIntent(.changeEmail(RegistrationData.stubValid.email))
        vm.onIntent(.changePassword(RegistrationData.stubValid.password))
        await vm.onIntent(.register).value
        
        XCTAssert(vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, nil)
        // XCTAssertEqual(fc.handleFlowValue, .registration(.dismiss))
        XCTAssert(registrationUseCase.executeReceivedInvocations == [.stubValid])
    }
    
    func testRegisterExistingEmail() async {
        let vm = createViewModel()
        registrationUseCase.executeThrowableError = AuthError.registration(.userAlreadyExists)
        
        vm.onIntent(.changeEmail(RegistrationData.stubValid.email))
        vm.onIntent(.changePassword(RegistrationData.stubValid.password))
        await vm.onIntent(.register).value
        
        XCTAssert(!vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.register_view_email_already_exists))
        // XCTAssertEqual(fc.handleFlowValue, nil)
        XCTAssert(registrationUseCase.executeReceivedInvocations == [.stubValid])
    }

    func testLogin() async {
        let vm = createViewModel()
        
        await vm.onIntent(.login).value
        
        XCTAssert(!vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, nil)
        // XCTAssertEqual(fc.handleFlowValue, .registration(.pop))
        XCTAssertEqual(registrationUseCase.executeCallsCount, 0)
    }
}
