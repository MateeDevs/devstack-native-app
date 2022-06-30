//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Firebase
import FirebaseAnalytics

public struct FirebaseAnalyticsProvider {
    
    public init(
        debugMode: Bool,
        processInfo: ProcessInfo
    ) {
        // Start Firebase if not yet started
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // Enable Firebase Analytics debug mode for non production environments
        // Idea taken from: https://stackoverflow.com/a/47594030/6947225
        if debugMode {
            var args = processInfo.arguments
            args.append("-FIRAnalyticsDebugEnabled")
            processInfo.setValue(args, forKey: "arguments")
        }
    }
}

extension FirebaseAnalyticsProvider: AnalyticsProvider {
    
    public func track(_ name: String, params: [String: AnyHashable]) {
        Analytics.logEvent(name, parameters: params)
    }
}
