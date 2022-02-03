//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import Resolver

public struct AnalyticsRepositoryImpl: AnalyticsRepository {
    
    @Injected private var analyticsProvider: AnalyticsProvider
    
    public func create(_ event: AnalyticsEvent) {
        analyticsProvider.track(event)
    }
}
