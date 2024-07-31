//
//  Created by Petr Chmelar on 06.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Factory
import SharedDomain

public extension Container {
    // Analytics
    var trackAnalyticsEventUseCase: Factory<TrackAnalyticsEventUseCase> { self { TrackAnalyticsEventUseCaseImpl(
        analyticsRepository: self.analyticsRepository()
    )}}
}
