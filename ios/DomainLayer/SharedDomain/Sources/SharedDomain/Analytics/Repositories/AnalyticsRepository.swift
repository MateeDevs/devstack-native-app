//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol AnalyticsRepository {
    func create(_ event: AnalyticsEvent)
}
