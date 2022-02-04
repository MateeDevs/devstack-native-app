//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver

public protocol GetProfileIdUseCase: AutoMockable {
    func execute() -> String?
}

public struct GetProfileIdUseCaseImpl: GetProfileIdUseCase {
    
    @Injected private var authTokenRepository: AuthTokenRepository
    
    public func execute() -> String? {
        authTokenRepository.read()?.userId
    }
}
