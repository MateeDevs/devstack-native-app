//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import DependencyInjection
import Factory
@testable import Profile
@testable import SharedDomain
import UIToolkit
import XCTest

@MainActor
final class ProfileViewModelTests: XCTestCase {

    // MARK: Dependencies
    
    private let fc = FlowControllerMock<ProfileFlow>(navigationController: UINavigationController())
    
    private let getProfileUseCase = GetProfileUseCaseSpy()
    private let getCurrentLocationUseCase = GetCurrentLocationUseCaseSpy()
    private let getRemoteConfigValueUseCase = GetRemoteConfigValueUseCaseSpy()
    private let registerForPushNotificationsUseCase = RegisterForPushNotificationsUseCaseSpy()
    private let logoutUseCase = LogoutUseCaseSpy()
    
    private func createViewModel() -> ProfileViewModel {
        Container.shared.reset()
        Container.shared.getProfileUseCase.register { self.getProfileUseCase }
        Container.shared.getCurrentLocationUseCase.register { self.getCurrentLocationUseCase }
        Container.shared.getRemoteConfigValueUseCase.register { self.getRemoteConfigValueUseCase }
        Container.shared.registerForPushNotificationsUseCase.register { self.registerForPushNotificationsUseCase }
        Container.shared.logoutUseCase.register { self.logoutUseCase }
        
        return ProfileViewModel(flowController: fc)
    }

    // MARK: Tests
    
    func testAppear() async {
        let location = CLLocation(latitude: 50.0, longitude: 50.0)
        let vm = createViewModel()
        getProfileUseCase.executeReturnValue = User.stub
        getRemoteConfigValueUseCase.executeReturnValue = true
        getCurrentLocationUseCase.executeReturnValue = AsyncStream(CLLocation.self) { continuation in
            continuation.yield(location)
            continuation.finish()
        }
        
        vm.onAppear()
        await vm.awaitAllTasks()
        
        XCTAssertEqual(vm.state.profile, User.stub)
        XCTAssertEqual(vm.state.currentLocation, location.coordinate.toString())
        XCTAssertEqual(vm.state.remoteConfigLabelIsVisible, true)
        XCTAssert(getProfileUseCase.executeReceivedInvocations == [.local, .remote])
        XCTAssert(getRemoteConfigValueUseCase.executeReceivedInvocations == [.profileLabelIsVisible])
        XCTAssertEqual(getCurrentLocationUseCase.executeCallsCount, 1)
    }
    
    func testRegisterForPushNotifications() async {
        let vm = createViewModel()
        
        vm.onIntent(.registerForPushNotifications)
        await vm.awaitAllTasks()
        
        XCTAssertEqual(registerForPushNotificationsUseCase.executeOptionsCompletionHandlerCallsCount, 1)
    }
    
    func testLogout() async {
        let vm = createViewModel()
        
        vm.onIntent(.logout)
        await vm.awaitAllTasks()
        
        XCTAssertEqual(fc.handleFlowValue, .profile(.presentOnboarding))
        XCTAssertEqual(logoutUseCase.executeCallsCount, 1)
    }
}
