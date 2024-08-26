//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Spyable
import Utilities

@Spyable
public protocol GetUsersUseCase {
    func execute(
        _ sourceType: SourceType,
        page: Int,
        limit: Int
    ) async throws -> Pages<User>
}

public struct GetUsersUseCaseImpl: GetUsersUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(
        _ sourceType: SourceType,
        page: Int,
        limit: Int
    ) async throws -> Pages<User> {
        try await userRepository.read(sourceType, page: page, limit: limit, sortBy: "id")
    }
}
