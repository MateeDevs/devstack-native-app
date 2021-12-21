//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public struct AnalyticsRepositoryImpl: AnalyticsRepository {
    
    public typealias Dependencies =
        HasAnalyticsProvider

    private let analyticsProvider: AnalyticsProvider

    public init(dependencies: Dependencies) {
        self.analyticsProvider = dependencies.analyticsProvider
    }
    
    public func create(_ event: AnalyticsEvent) {
        analyticsProvider.track(event)
    }
}
