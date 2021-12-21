//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public protocol HasAnalyticsProvider {
    var analyticsProvider: AnalyticsProvider { get }
}

public protocol AnalyticsProvider: AutoMockable {
    /// Track a given event
    func track(_ event: AnalyticsEvent)
}
