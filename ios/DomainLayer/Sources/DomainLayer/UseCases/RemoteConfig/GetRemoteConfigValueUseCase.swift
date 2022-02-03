//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasGetRemoteConfigValueUseCase {
    var getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase { get }
}

public protocol GetRemoteConfigValueUseCase: AutoMockable {
    func execute(_ key: RemoteConfigCoding) -> Observable<Bool>
}

public struct GetRemoteConfigValueUseCaseImpl: GetRemoteConfigValueUseCase {
    
    @Injected private var remoteConfigRepository: RemoteConfigRepository
    
    public func execute(_ key: RemoteConfigCoding) -> Observable<Bool> {
        remoteConfigRepository.read(key)
    }
}
