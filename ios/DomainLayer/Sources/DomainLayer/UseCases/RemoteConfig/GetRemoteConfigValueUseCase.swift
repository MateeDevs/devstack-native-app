//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasGetRemoteConfigValueUseCase {
    var getRemoteConfigValueUseCase: GetRemoteConfigValueUseCase { get }
}

public protocol GetRemoteConfigValueUseCase: AutoMockable {
    func execute(_ key: RemoteConfigCoding) -> Observable<Bool>
}

public struct GetRemoteConfigValueUseCaseImpl: GetRemoteConfigValueUseCase {
    
    public typealias Dependencies =
        HasRemoteConfigRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(_ key: RemoteConfigCoding) -> Observable<Bool> {
        dependencies.remoteConfigRepository.read(key)
    }
}
