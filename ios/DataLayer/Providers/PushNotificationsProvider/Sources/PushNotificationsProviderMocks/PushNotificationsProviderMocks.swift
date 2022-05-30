//
//  Created by Petr Chmelar on 28.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import PushNotificationsProvider
import UserNotifications

public final class PushNotificationsProviderMock: PushNotificationsProvider {

    public init() {}

    // MARK: - requestAuthorization

    public var requestAuthorizationOptionsCompletionHandlerCallsCount = 0
    public var requestAuthorizationOptionsCompletionHandlerCalled: Bool {
        return requestAuthorizationOptionsCompletionHandlerCallsCount > 0
    }
    public var requestAuthorizationOptionsCompletionHandlerReceivedArguments: (
        options: UNAuthorizationOptions,
        completionHandler: (Bool, Error?) -> Void
    )?
    public var requestAuthorizationOptionsCompletionHandlerReceivedInvocations: [(
        options: UNAuthorizationOptions,
        completionHandler: (Bool, Error?) -> Void
    )] = []
    public var requestAuthorizationOptionsCompletionHandlerClosure: ((UNAuthorizationOptions, @escaping (Bool, Error?) -> Void) -> Void)?

    public func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        requestAuthorizationOptionsCompletionHandlerCallsCount += 1
        requestAuthorizationOptionsCompletionHandlerReceivedArguments = (options: options, completionHandler: completionHandler)
        requestAuthorizationOptionsCompletionHandlerReceivedInvocations.append((options: options, completionHandler: completionHandler))
        requestAuthorizationOptionsCompletionHandlerClosure?(options, completionHandler)
    }

}
