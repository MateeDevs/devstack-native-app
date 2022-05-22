//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol UpdateProfileCounterUseCase: AutoMockable {
    func execute(value: Int) async throws
}

public struct UpdateProfileCounterUseCaseImpl: UpdateProfileCounterUseCase {
    
    private let userRepository: UserRepository
    private let getProfileIdUseCase: GetProfileIdUseCase
    
    public init(
        userRepository: UserRepository,
        getProfileIdUseCase: GetProfileIdUseCase
    ) {
        self.userRepository = userRepository
        self.getProfileIdUseCase = getProfileIdUseCase
    }
    
    public func execute(value: Int) async throws {
        let profileId = try getProfileIdUseCase.execute()
        let profile = try await userRepository.read(.local, id: profileId)
        let updatedProfile = User(copy: profile, counter: value)
        _ = try await userRepository.update(.local, user: updatedProfile)
    }
}
