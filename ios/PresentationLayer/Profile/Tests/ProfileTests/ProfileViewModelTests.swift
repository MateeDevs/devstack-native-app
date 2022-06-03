//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
@testable import Profile
import Resolver
import SharedDomain
import SharedDomainMocks
import UIToolkit
import XCTest

@MainActor
class ProfileViewModelTests: XCTestCase {

    // MARK: Dependencies
    
    private let fc = FlowControllerMock<ProfileFlow>(navigationController: UINavigationController())
    
    private let getProfileUseCase = GetProfileUseCaseMock()
    private let getCurrentLocationUseCase = GetCurrentLocationUseCaseMock()
    private let getRemoteConfigValueUseCase = GetRemoteConfigValueUseCaseMock()
    private let registerForPushNotificationsUseCase = RegisterForPushNotificationsUseCaseMock()
    private let logoutUseCase = LogoutUseCaseMock()
    
    private func createViewModel() -> ProfileViewModel {
        Resolver.register { self.getProfileUseCase as GetProfileUseCase }
        Resolver.register { self.getCurrentLocationUseCase as GetCurrentLocationUseCase }
        Resolver.register { self.getRemoteConfigValueUseCase as GetRemoteConfigValueUseCase }
        Resolver.register { self.registerForPushNotificationsUseCase as RegisterForPushNotificationsUseCase }
        Resolver.register { self.logoutUseCase as LogoutUseCase }
        
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
