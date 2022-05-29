//
//  Created by Petr Chmelar on 28.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import AnalyticsProvider
import Foundation

public final class AnalyticsProviderMock: AnalyticsProvider {

    public init() {}

    // MARK: - track

    public var trackParamsCallsCount = 0
    public var trackParamsCalled: Bool {
        return trackParamsCallsCount > 0
    }
    public var trackParamsReceivedArguments: (name: String, params: [String: AnyHashable])?
    public var trackParamsReceivedInvocations: [(name: String, params: [String: AnyHashable])] = []
    public var trackParamsClosure: ((String, [String: AnyHashable]) -> Void)?

    public func track(_ name: String, params: [String: AnyHashable]) {
        trackParamsCallsCount += 1
        trackParamsReceivedArguments = (name: name, params: params)
        trackParamsReceivedInvocations.append((name: name, params: params))
        trackParamsClosure?(name, params)
    }

}
