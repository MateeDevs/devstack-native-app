//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import Resolver
import RxSwift

public struct RemoteConfigRepositoryImpl: RemoteConfigRepository {
    
    @Injected private var remoteConfig: RemoteConfigProvider
    
    public func read(_ key: RemoteConfigCoding) -> Observable<Bool> {
        remoteConfig.get(key)
    }
}
