//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import Firebase
import FirebaseRemoteConfig

public struct FirebaseRemoteConfigProvider {
    
    public init() {
        // Start Firebase if not yet started
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // Set fetch interval to zero for non production environments
        if Environment.type != .production {
            let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0
            RemoteConfig.remoteConfig().configSettings = settings
        }
    }
}

extension FirebaseRemoteConfigProvider: RemoteConfigProvider {
    
    public func read(_ key: RemoteConfigCoding) async throws -> Bool {
        try await RemoteConfig.remoteConfig().fetch()
        return RemoteConfig.remoteConfig().configValue(forKey: key.rawValue).boolValue
    }
}
