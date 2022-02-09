//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol GetProfileIdUseCase: AutoMockable {
    func execute() -> String?
}

public struct GetProfileIdUseCaseImpl: GetProfileIdUseCase {
    
    private let authTokenRepository: AuthTokenRepository
    
    public init(authTokenRepository: AuthTokenRepository) {
        self.authTokenRepository = authTokenRepository
    }
    
    public func execute() -> String? {
        authTokenRepository.read()?.userId
    }
}
