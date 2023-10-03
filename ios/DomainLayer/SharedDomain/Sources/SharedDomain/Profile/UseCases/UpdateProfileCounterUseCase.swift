//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Spyable

@Spyable
public protocol UpdateProfileCounterUseCase {
    func execute(value: Int) async throws
}

public struct UpdateProfileCounterUseCaseImpl: UpdateProfileCounterUseCase {
    
    private let getProfileIdUseCase: GetProfileIdUseCase
    private let getUserUseCase: GetUserUseCase
    private let updateUserUseCase: UpdateUserUseCase
    
    public init(
        getProfileIdUseCase: GetProfileIdUseCase,
        getUserUseCase: GetUserUseCase,
        updateUserUseCase: UpdateUserUseCase
    ) {
        self.getProfileIdUseCase = getProfileIdUseCase
        self.getUserUseCase = getUserUseCase
        self.updateUserUseCase = updateUserUseCase
    }
    
    public func execute(value: Int) async throws {
        let profileId = try getProfileIdUseCase.execute()
        let profile = try await getUserUseCase.execute(.local, id: profileId)
        let updatedProfile = User(copy: profile, counter: value)
        try await updateUserUseCase.execute(.local, user: updatedProfile)
    }
}
