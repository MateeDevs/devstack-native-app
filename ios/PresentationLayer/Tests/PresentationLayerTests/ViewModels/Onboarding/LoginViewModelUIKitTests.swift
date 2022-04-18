//
//  Created by Petr Chmelar on 20/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DomainLayer
import DomainStubs
@testable import PresentationLayer
import RxSwift
import RxTest
import SwiftyMocky
import UseCaseMocks
import XCTest

class LoginViewModelUIKitTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let loginUseCase = LoginUseCaseMock()
    private let trackAnalyticsEventUseCase = TrackAnalyticsEventUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Given(loginUseCase, .executeRx(
            .value(.stubInvalidPassword),
            willReturn: .error(RepositoryError(statusCode: StatusCode.httpUnathorized, message: ""))
        ))
        Given(loginUseCase, .executeRx(.any, willReturn: .just(())))
    }

    // MARK: Inputs and outputs

    private struct Input {
        var loginData: [(time: TestTime, element: LoginData)] = []
        var loginButtonTaps: [(time: TestTime, element: Void)] = []
        var registerButtonTaps: [(time: TestTime, element: Void)] = []

        static let loginEmpty = Input(loginButtonTaps: [(0, ())])
        static let loginValid = Input(loginData: [(0, .stubValid)], loginButtonTaps: [(0, ())])
        static let loginInvalidPassword = Input(loginData: [(0, .stubInvalidPassword)], loginButtonTaps: [(0, ())])
        static let loginInvalidThenValid = Input(
            loginData: [(0, .stubInvalidPassword), (10, .stubValid)],
            loginButtonTaps: [(0, ()), (10, ())]
        )
        static let register = Input(registerButtonTaps: [(0, ())])
    }
    
    private struct Output {
        let flow: TestableObserver<Flow.Login>
        let alertAction: TestableObserver<AlertAction>
        let loginButtonEnabled: TestableObserver<Bool>
    }

    private func generateOutput(for input: Input) -> Output {
        let viewModel = LoginViewModelUIKit(
            loginUseCase: loginUseCase,
            trackAnalyticsEventUseCase: trackAnalyticsEventUseCase
        )
        
        scheduler.createColdObservable(input.loginData.map { .next($0.time, $0.element.email) })
            .bind(to: viewModel.input.email).disposed(by: disposeBag)

        scheduler.createColdObservable(input.loginData.map { .next($0.time, $0.element.password) })
            .bind(to: viewModel.input.password).disposed(by: disposeBag)

        scheduler.createColdObservable(input.loginButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.loginButtonTaps).disposed(by: disposeBag)

        scheduler.createColdObservable(input.registerButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.registerButtonTaps).disposed(by: disposeBag)
        
        return Output(
            flow: testableOutput(from: viewModel.output.flow),
            alertAction: testableOutput(from: viewModel.output.alertAction),
            loginButtonEnabled: testableOutput(from: viewModel.output.loginButtonEnabled)
        )
    }

    // MARK: Tests

    func testLoginEmpty() {
        let output = generateOutput(for: .loginEmpty)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(WhisperData(error: L10n.invalid_credentials)))
        ])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true)
        ])
        Verify(loginUseCase, 0, .execute(.any))
    }

    func testLoginValid() {
        let output = generateOutput(for: .loginValid)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [
            .next(0, .dismiss)
        ])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(WhisperData(L10n.signing_in))),
            .next(0, .hideWhisper)
        ])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true)
        ])
        Verify(loginUseCase, 1, .executeRx(.value(.stubValid)))
        Verify(trackAnalyticsEventUseCase, 1, .execute(.value(LoginEvent.loginButtonTap.analyticsEvent)))
    }

    func testLoginInvalidPassword() {
        let output = generateOutput(for: .loginInvalidPassword)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(WhisperData(L10n.signing_in))),
            .next(0, .showWhisper(WhisperData(error: L10n.invalid_credentials)))
        ])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true)
        ])
        Verify(loginUseCase, 1, .executeRx(.value(.stubInvalidPassword)))
    }
    
    func testLoginInvalidThenValid() {
        let output = generateOutput(for: .loginInvalidThenValid)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [
            .next(10, .dismiss)
        ])
        XCTAssertEqual(output.alertAction.events, [
            .next(0, .showWhisper(WhisperData(L10n.signing_in))),
            .next(0, .showWhisper(WhisperData(error: L10n.invalid_credentials))),
            .next(10, .showWhisper(WhisperData(L10n.signing_in))),
            .next(10, .hideWhisper)
        ])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true),
            .next(0, false),
            .next(0, true),
            .next(10, false),
            .next(10, true)
        ])
        Verify(loginUseCase, 1, .executeRx(.value(.stubInvalidPassword)))
        Verify(loginUseCase, 1, .executeRx(.value(.stubValid)))
    }

    func testRegister() {
        let output = generateOutput(for: .register)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [
            .next(0, .showRegistration)
        ])
        XCTAssertEqual(output.alertAction.events, [])
        XCTAssertEqual(output.loginButtonEnabled.events, [
            .next(0, true)
        ])
        Verify(loginUseCase, 0, .executeRx(.any))
        Verify(trackAnalyticsEventUseCase, 1, .execute(.value(LoginEvent.registerButtonTap.analyticsEvent)))
    }
}