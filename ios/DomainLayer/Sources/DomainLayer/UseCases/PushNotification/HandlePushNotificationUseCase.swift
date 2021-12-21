//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol HasHandlePushNotificationUseCase {
    var handlePushNotificationUseCase: HandlePushNotificationUseCase { get }
}

public protocol HandlePushNotificationUseCase: AutoMockable {
    func execute(_ notificationData: [AnyHashable: Any]) -> PushNotification?
}

public struct HandlePushNotificationUseCaseImpl: HandlePushNotificationUseCase {
    
    public typealias Dependencies = HasPushNotificationsRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(_ notificationData: [AnyHashable: Any]) -> PushNotification? {
        dependencies.pushNotificationsRepository.decode(notificationData)
    }
}
