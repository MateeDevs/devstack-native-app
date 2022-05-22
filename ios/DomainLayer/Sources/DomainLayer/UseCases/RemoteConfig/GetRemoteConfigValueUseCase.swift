//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol GetRemoteConfigValueUseCase: AutoMockable {
    func execute(_ key: RemoteConfigCoding) async throws -> Bool
}

public struct GetRemoteConfigValueUseCaseImpl: GetRemoteConfigValueUseCase {
    
    private let remoteConfigRepository: RemoteConfigRepository
    
    public init(remoteConfigRepository: RemoteConfigRepository) {
        self.remoteConfigRepository = remoteConfigRepository
    }
    
    public func execute(_ key: RemoteConfigCoding) async throws -> Bool {
        try await remoteConfigRepository.read(key)
    }
}
