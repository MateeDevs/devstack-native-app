//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RemoteConfigProvider
import SharedDomain

public struct RemoteConfigRepositoryImpl: RemoteConfigRepository {
    
    private let remoteConfig: RemoteConfigProvider
    
    public init(remoteConfigProvider: RemoteConfigProvider) {
        remoteConfig = remoteConfigProvider
    }
    
    public func read(_ key: RemoteConfigCoding) async throws -> Bool {
        try await remoteConfig.read(key.rawValue)
    }
}
