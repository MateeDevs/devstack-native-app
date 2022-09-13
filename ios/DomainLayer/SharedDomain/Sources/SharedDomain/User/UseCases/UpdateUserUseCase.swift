//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

// sourcery: AutoMockable
public protocol UpdateUserUseCase {
    func execute(_ sourceType: SourceType, user: User) async throws
}

public struct UpdateUserUseCaseImpl: UpdateUserUseCase {
    
    private let userRepository: UserRepository
    private let validateFirstNameUseCase: ValidateFirstNameUseCase
    private let validateLastNameUseCase: ValidateLastNameUseCase
    private let validatePhoneUseCase: ValidatePhoneUseCase
    
    public init(
        userRepository: UserRepository,
        validateFirstNameUseCase: ValidateFirstNameUseCase,
        validateLastNameUseCase: ValidateLastNameUseCase,
        validatePhoneUseCase: ValidatePhoneUseCase
    ) {
        self.userRepository = userRepository
        self.validateFirstNameUseCase = validateFirstNameUseCase
        self.validateLastNameUseCase = validateLastNameUseCase
        self.validatePhoneUseCase = validatePhoneUseCase
    }
    
    public func execute(_ sourceType: SourceType, user: User) async throws {
        try validateFirstNameUseCase.execute(user.firstName)
        try validateLastNameUseCase.execute(user.lastName)
        try validatePhoneUseCase.execute(user.phone)
        _ = try await userRepository.update(sourceType, user: user)
    }
}
