//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol LogoutUseCase: AutoMockable {
    func execute() throws
}

public struct LogoutUseCaseImpl: LogoutUseCase {
    
    private let authTokenRepository: AuthTokenRepository
    
    public init(authTokenRepository: AuthTokenRepository) {
        self.authTokenRepository = authTokenRepository
    }
    
    public func execute() throws {
        try authTokenRepository.delete()
    }
}
