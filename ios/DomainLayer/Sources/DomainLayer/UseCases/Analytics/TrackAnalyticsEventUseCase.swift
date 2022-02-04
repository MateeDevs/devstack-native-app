//
//  Created by Petr Chmelar on 27.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol TrackAnalyticsEventUseCase: AutoMockable {
    func execute(_ event: AnalyticsEvent)
}

public struct TrackAnalyticsEventUseCaseImpl: TrackAnalyticsEventUseCase {
    
    @Injected private var analyticsRepository: AnalyticsRepository
    
    public func execute(_ event: AnalyticsEvent) {
        analyticsRepository.create(event)
    }
}
