//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol GetUsersUseCase: AutoMockable {
    func execute(_ sourceType: SourceType, page: Int) async throws -> [User]
}

public struct GetUsersUseCaseImpl: GetUsersUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(_ sourceType: SourceType, page: Int) async throws -> [User] {
        try await userRepository.read(sourceType, page: page, sortBy: "id")
    }
}
