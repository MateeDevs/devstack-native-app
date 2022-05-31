//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
@testable import PresentationLayer
import Resolver
import SwiftyMocky
import UseCaseMocks
import XCTest

class RegistrationViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let registrationUseCase = RegistrationUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Resolver.register { self.registrationUseCase as RegistrationUseCase }
        
        Given(registrationUseCase, .execute(.value(.stubEmptyEmail), willThrow: ValidationError.email(.isEmpty)))
        Given(registrationUseCase, .execute(.value(.stubEmptyPassword), willThrow: ValidationError.password(.isEmpty)))
        Given(registrationUseCase, .execute(.value(.stubExistingEmail), willThrow: AuthError.registration(.userAlreadyExists)))
    }

    // MARK: Tests

    func testRegisterEmptyEmail() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = RegistrationViewModel(flowController: fc)
        
        vm.onIntent(.changeEmail(RegistrationData.stubEmptyEmail.email))
        vm.onIntent(.changePassword(RegistrationData.stubEmptyEmail.password))
        await vm.onIntent(.register).value
        
        XCTAssert(!vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.invalid_email))
        XCTAssertEqual(fc.handleFlowValue, nil)
        Verify(registrationUseCase, 1, .execute(.value(.stubEmptyEmail)))
    }
    
    func testRegisterEmptyPassword() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = RegistrationViewModel(flowController: fc)
        
        vm.onIntent(.changeEmail(RegistrationData.stubEmptyPassword.email))
        vm.onIntent(.changePassword(RegistrationData.stubEmptyPassword.password))
        await vm.onIntent(.register).value
        
        XCTAssert(!vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.invalid_password))
        XCTAssertEqual(fc.handleFlowValue, nil)
        Verify(registrationUseCase, 1, .execute(.value(.stubEmptyPassword)))
    }
    
    func testRegisterValid() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = RegistrationViewModel(flowController: fc)
        
        vm.onIntent(.changeEmail(RegistrationData.stubValid.email))
        vm.onIntent(.changePassword(RegistrationData.stubValid.password))
        await vm.onIntent(.register).value
        
        XCTAssert(vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, nil)
        XCTAssertEqual(fc.handleFlowValue, .registration(.dismiss))
        Verify(registrationUseCase, 1, .execute(.value(.stubValid)))
    }
    
    func testRegisterExistingEmail() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = RegistrationViewModel(flowController: fc)
        
        vm.onIntent(.changeEmail(RegistrationData.stubExistingEmail.email))
        vm.onIntent(.changePassword(RegistrationData.stubExistingEmail.password))
        await vm.onIntent(.register).value
        
        XCTAssert(!vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, AlertData(title: L10n.register_view_email_already_exists))
        XCTAssertEqual(fc.handleFlowValue, nil)
        Verify(registrationUseCase, 1, .execute(.value(.stubExistingEmail)))
    }

    func testLogin() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = RegistrationViewModel(flowController: fc)
        
        await vm.onIntent(.login).value
        
        XCTAssert(!vm.state.registerButtonLoading)
        XCTAssertEqual(vm.state.alert, nil)
        XCTAssertEqual(fc.handleFlowValue, .registration(.pop))
        Verify(registrationUseCase, 0, .execute(.any))
    }
}
