//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol GetProfileUseCase: AutoMockable {
    func execute(_ sourceType: SourceType) async throws -> User
}

public struct GetProfileUseCaseImpl: GetProfileUseCase {
    
    private let userRepository: UserRepository
    private let getProfileIdUseCase: GetProfileIdUseCase
    
    public init(
        userRepository: UserRepository,
        getProfileIdUseCase: GetProfileIdUseCase
    ) {
        self.userRepository = userRepository
        self.getProfileIdUseCase = getProfileIdUseCase
    }
    
    public func execute(_ sourceType: SourceType) async throws -> User {
        let profileId = try getProfileIdUseCase.execute()
        return try await userRepository.read(sourceType, id: profileId)
    }
}
