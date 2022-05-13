//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol LoginUseCase: AutoMockable {
    func execute(_ data: LoginData) async throws
}

public struct LoginUseCaseImpl: LoginUseCase {
    
    private let authTokenRepository: AuthTokenRepository
    
    public init(authTokenRepository: AuthTokenRepository) {
        self.authTokenRepository = authTokenRepository
    }
    
    public func execute(_ data: LoginData) async throws {
        _ = try await authTokenRepository.create(data)
    }
}
