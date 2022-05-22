//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol UpdateUserUseCase: AutoMockable {
    func execute(_ sourceType: SourceType, user: User) async throws
}

public struct UpdateUserUseCaseImpl: UpdateUserUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(_ sourceType: SourceType, user: User) async throws {
        _ = try await userRepository.update(sourceType, user: user)
    }
}
