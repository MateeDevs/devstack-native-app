//
//  Created by Petr Chmelar on 26.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreLocation
import DomainLayer
import DomainStubs
@testable import PresentationLayer
import Resolver
import SwiftyMocky
import UseCaseMocks
import XCTest

class ProfileViewModelTests: BaseTestCase {
    
    private let locationStub = CLLocation(latitude: 50.0, longitude: 50.0)
    
    // MARK: Dependencies
    
    private let getProfileUseCase = GetProfileUseCaseMock()
    private let getCurrentLocationUseCase = GetCurrentLocationUseCaseMock()
    private let getRemoteConfigValueUseCase = GetRemoteConfigValueUseCaseMock()
    private let registerForPushNotificationsUseCase = RegisterForPushNotificationsUseCaseMock()
    private let logoutUseCase = LogoutUseCaseMock()
    
    override func setupDependencies() {
        super.setupDependencies()
        
        Resolver.register { self.getProfileUseCase as GetProfileUseCase }
        Resolver.register { self.getCurrentLocationUseCase as GetCurrentLocationUseCase }
        Resolver.register { self.getRemoteConfigValueUseCase as GetRemoteConfigValueUseCase }
        Resolver.register { self.registerForPushNotificationsUseCase as RegisterForPushNotificationsUseCase }
        Resolver.register { self.logoutUseCase as LogoutUseCase }
        
        let locationStream = AsyncStream(CLLocation.self) { continuation in
            continuation.yield(locationStub)
            continuation.finish()
        }
        
        Given(getProfileUseCase, .execute(.any, willReturn: User.stub))
        Given(getCurrentLocationUseCase, .execute(willReturn: locationStream))
        Given(getRemoteConfigValueUseCase, .execute(.value(.profileLabelIsVisible), willReturn: true))
    }

    // MARK: Tests
    
    func testAppear() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = ProfileViewModel(flowController: fc)
        
        vm.onAppear()
        for task in vm.tasks { await task.value }
        
        XCTAssertEqual(vm.state.profile, User.stub)
        XCTAssertEqual(vm.state.currentLocation, locationStub.coordinate.toString())
        XCTAssertEqual(vm.state.remoteConfigLabelIsVisible, true)
        Verify(getProfileUseCase, 1, .execute(.value(.local)))
        Verify(getProfileUseCase, 1, .execute(.value(.remote)))
        Verify(getCurrentLocationUseCase, 1, .execute())
        Verify(getRemoteConfigValueUseCase, 1, .execute(.value(.profileLabelIsVisible)))
    }
    
    func testRegisterForPushNotifications() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = ProfileViewModel(flowController: fc)
        
        await vm.onIntent(.registerForPushNotifications).value
        
        Verify(registerForPushNotificationsUseCase, 1, .execute(options: .value([.alert, .badge, .sound]), completionHandler: .any))
    }
    
    func testLogout() async {
        let fc = FlowControllerMock(navigationController: UINavigationController())
        let vm = ProfileViewModel(flowController: fc)
        
        await vm.onIntent(.logout).value
        
        XCTAssertEqual(fc.handleFlowValue, .profile(.presentOnboarding))
        Verify(logoutUseCase, 1, .execute())
    }
}
