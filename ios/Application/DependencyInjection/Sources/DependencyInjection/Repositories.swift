//
//  Created by Petr Chmelar on 06.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import AnalyticsToolkit
import Factory
import SharedDomain

public extension Container {
    var analyticsRepository: Factory<AnalyticsRepository> { self { AnalyticsRepositoryImpl(
        analyticsProvider: self.analyticsProvider()
    )}}
}
