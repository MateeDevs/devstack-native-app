//
//  Created by Petr Chmelar on 27.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Spyable

@Spyable
public protocol TrackAnalyticsEventUseCase {
    func execute(_ event: AnalyticsEvent)
}

public struct TrackAnalyticsEventUseCaseImpl: TrackAnalyticsEventUseCase {
    
    private let analyticsRepository: AnalyticsRepository
    
    public init(analyticsRepository: AnalyticsRepository) {
        self.analyticsRepository = analyticsRepository
    }
    
    public func execute(_ event: AnalyticsEvent) {
        analyticsRepository.create(event)
    }
}
