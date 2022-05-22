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
        if data.email.isEmpty {
            throw ValidationError.email(.isEmpty)
        } else if data.password.isEmpty {
            throw ValidationError.password(.isEmpty)
        } else {
            _ = try await userRepository.create(data)
        }
    }
}
