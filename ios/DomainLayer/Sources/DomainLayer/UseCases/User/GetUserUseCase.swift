//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol GetUserUseCase: AutoMockable {
    func execute(_ sourceType: SourceType, id: String) async throws -> User
}

public struct GetUserUseCaseImpl: GetUserUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(_ sourceType: SourceType, id: String) async throws -> User {
        try await userRepository.read(sourceType, id: id)
    }
}
