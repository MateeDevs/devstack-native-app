//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RxSwift

public struct RemoteConfigRepositoryImpl: RemoteConfigRepository {
    
    public typealias Dependencies =
        HasRemoteConfigProvider

    private let remoteConfig: RemoteConfigProvider

    public init(dependencies: Dependencies) {
        self.remoteConfig = dependencies.remoteConfigProvider
    }
    
    public func read(_ key: RemoteConfigCoding) -> Observable<Bool> {
        remoteConfig.get(key)
    }
}
