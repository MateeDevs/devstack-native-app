//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol GetProfileUseCase: AutoMockable {
    func execute(_ sourceType: SourceType) async throws -> User
}

public struct GetProfileUseCaseImpl: GetProfileUseCase {
    
    private let getProfileIdUseCase: GetProfileIdUseCase
    private let getUserUseCase: GetUserUseCase
    
    public init(
        getProfileIdUseCase: GetProfileIdUseCase,
        getUserUseCase: GetUserUseCase
    ) {
        self.getProfileIdUseCase = getProfileIdUseCase
        self.getUserUseCase = getUserUseCase
    }
    
    public func execute(_ sourceType: SourceType) async throws -> User {
        let profileId = try getProfileIdUseCase.execute()
        return try await getUserUseCase.execute(sourceType, id: profileId)
    }
}
