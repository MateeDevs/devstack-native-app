//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Firebase
import FirebaseAnalytics

public struct FirebaseAnalyticsProvider {
    public init() {
        // Start Firebase if not yet started
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
}

extension FirebaseAnalyticsProvider: AnalyticsProvider {
    
    public func track(_ name: String, params: [String: AnyHashable]) {
        Analytics.logEvent(name, parameters: params)
    }
}
