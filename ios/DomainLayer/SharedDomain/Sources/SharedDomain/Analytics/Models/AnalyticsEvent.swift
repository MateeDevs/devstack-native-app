//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol Trackable {
    var analyticsEvent: AnalyticsEvent { get }
}

public struct AnalyticsEvent: Equatable {
    public let name: String
    public let params: [String: AnyHashable]
    
    public init(
        name: String,
        params: [String: AnyHashable] = [:]
    ) {
        self.name = name
        self.params = params
    }
}
