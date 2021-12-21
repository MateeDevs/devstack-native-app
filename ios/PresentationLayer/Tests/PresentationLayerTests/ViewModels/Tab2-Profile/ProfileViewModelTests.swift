//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import DomainLayer
import DomainStubs
@testable import PresentationLayer
import RxSwift
import RxTest
import SwiftyMocky
import UseCaseMocks
import XCTest

class ProfileViewModelTests: BaseTestCase {
    
    // MARK: Dependencies
    
    private let dbStream = BehaviorSubject<User>(value: User.stub)
    private let location = CLLocation(latitude: 50.0, longitude: 50.0)
    
    private let getProfileUseCase = GetProfileUseCaseMock()
    private let refreshProfileUseCase = RefreshProfileUseCaseMock()
    private let logoutUseCase = LogoutUseCaseMock()
    private let getCurrentLocationUseCase = GetCurrentLocationUseCaseMock()
    private let getRemoteConfigValueUseCase = GetRemoteConfigValueUseCaseMock()
    private let registerForPushNotificationsUseCase = RegisterForPushNotificationsUseCaseMock()
    
    private func setupDependencies() -> UseCaseDependency {
        Given(getProfileUseCase, .execute(willReturn: dbStream.asObservable()))
        Given(refreshProfileUseCase, .execute(willReturn: .just(())))
        Given(getCurrentLocationUseCase, .execute(willReturn: .just(location)))
        Given(getRemoteConfigValueUseCase, .execute(.value(.profileLabelIsVisible), willReturn: .just(true)))
        
        return UseCaseDependencyMock(
            logoutUseCase: logoutUseCase,
            getCurrentLocationUseCase: getCurrentLocationUseCase,
            getProfileUseCase: getProfileUseCase,
            refreshProfileUseCase: refreshProfileUseCase,
            registerForPushNotificationsUseCase: registerForPushNotificationsUseCase,
            getRemoteConfigValueUseCase: getRemoteConfigValueUseCase
        )
    }
    
    // MARK: Inputs and outputs
    
    private struct Input {
        var registerPushNotificationsButtonTaps: [(time: TestTime, element: Void)] = []
        var logoutButtonTaps: [(time: TestTime, element: Void)] = []
        
        static let initialLoad = Input()
        static let registerPushNotifications = Input(registerPushNotificationsButtonTaps: [(0, ())])
        static let logout = Input(logoutButtonTaps: [(0, ())])
    }
    
    private struct Output {
        let profile: OutputProfile
        let isRefreshing: TestableObserver<Bool>
        let currentLocation: TestableObserver<String>
        let remoteConfigLabelIsHidden: TestableObserver<Bool>
        let registerForPushNotifications: TestableObserver<Bool>
        let flow: TestableObserver<Flow.Profile>
    }
    
    private struct OutputProfile {
        let fullName: TestableObserver<String>
        let initials: TestableObserver<String>
        let imageURL: TestableObserver<String?>
    }
    
    private func generateOutput(for input: Input) -> Output {
        let viewModel = ProfileViewModel(dependencies: setupDependencies())
        
        scheduler.createColdObservable(input.registerPushNotificationsButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.registerPushNotificationsButtonTaps).disposed(by: disposeBag)
        
        scheduler.createColdObservable(input.logoutButtonTaps.map { .next($0.time, $0.element) })
            .bind(to: viewModel.input.logoutButtonTaps).disposed(by: disposeBag)
        
        return Output(
            profile: OutputProfile(
                fullName: testableOutput(from: viewModel.output.profile.fullName),
                initials: testableOutput(from: viewModel.output.profile.initials),
                imageURL: testableOutput(from: viewModel.output.profile.imageURL)
            ),
            isRefreshing: testableOutput(from: viewModel.output.isRefreshing),
            currentLocation: testableOutput(from: viewModel.output.currentLocation),
            remoteConfigLabelIsHidden: testableOutput(from: viewModel.output.remoteConfigLabelIsHidden),
            registerForPushNotifications: testableOutput(from: viewModel.output.registerForPushNotifications.map { _ in true }),
            flow: testableOutput(from: viewModel.output.flow)
        )
    }
    
    // MARK: Tests
    
    func testInitialLoad() {
        let output = generateOutput(for: .initialLoad)
        
        dbStream.onNext(User.stub) // Simulate refresh
        scheduler.start()
        
        XCTAssertEqual(output.profile.fullName.events, [
            .next(0, User.stub.fullName),
            .next(0, User.stub.fullName)
        ])
        XCTAssertEqual(output.profile.initials.events, [
            .next(0, User.stub.fullName.initials),
            .next(0, User.stub.fullName.initials)
        ])
        XCTAssertEqual(output.profile.imageURL.events, [
            .next(0, User.stub.pictureUrl),
            .next(0, User.stub.pictureUrl)
        ])
        XCTAssertEqual(output.isRefreshing.events, [
            .next(0, false),
            .next(0, true),
            .next(0, false),
            .next(0, false)
        ])
        XCTAssertEqual(output.currentLocation.events, [
            .next(0, location.coordinate.toString()),
            .completed(0)
        ])
        XCTAssertEqual(output.remoteConfigLabelIsHidden.events, [
            .next(0, false),
            .completed(0)
        ])
        XCTAssertEqual(output.registerForPushNotifications.events, [])
        XCTAssertEqual(output.flow.events, [])
        Verify(logoutUseCase, 0, .execute())
        Verify(getCurrentLocationUseCase, 1, .execute())
        Verify(getProfileUseCase, 1, .execute())
        Verify(refreshProfileUseCase, 1, .execute())
        Verify(registerForPushNotificationsUseCase, 0, .execute(options: .any, completionHandler: .any))
        Verify(getRemoteConfigValueUseCase, 1, .execute(.value(.profileLabelIsVisible)))
    }
    
    func testRegisterPushNotifications() {
        let output = generateOutput(for: .registerPushNotifications)
        
        scheduler.start()
        
        XCTAssertEqual(output.registerForPushNotifications.events, [
            .next(0, true)
        ])
        Verify(registerForPushNotificationsUseCase, 1, .execute(options: .value([.alert, .badge, .sound]), completionHandler: .any))
    }
    
    func testLogout() {
        let output = generateOutput(for: .logout)
        
        scheduler.start()
        
        XCTAssertEqual(output.flow.events, [
            .next(0, .presentOnboarding)
        ])
        Verify(logoutUseCase, 1, .execute())
    }
}
