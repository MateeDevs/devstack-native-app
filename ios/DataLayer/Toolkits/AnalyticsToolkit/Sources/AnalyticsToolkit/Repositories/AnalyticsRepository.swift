//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import AnalyticsProvider
import SharedDomain

public struct AnalyticsRepositoryImpl: AnalyticsRepository {
    
    private let analytics: AnalyticsProvider
    
    public init(analyticsProvider: AnalyticsProvider) {
        analytics = analyticsProvider
    }
    
    public func create(_ event: AnalyticsEvent) {
        analytics.track(event.name, params: event.params)
    }
}
