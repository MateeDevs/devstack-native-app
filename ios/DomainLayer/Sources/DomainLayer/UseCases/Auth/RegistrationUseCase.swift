//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol RegistrationUseCase: AutoMockable {
    func execute(_ data: RegistrationData) async throws
}

public struct RegistrationUseCaseImpl: RegistrationUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(_ data: RegistrationData) async throws {
        _ = try await userRepository.create(data)
    }
}
