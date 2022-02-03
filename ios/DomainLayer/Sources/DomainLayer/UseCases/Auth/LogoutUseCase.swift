//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver

public protocol HasLogoutUseCase {
    var logoutUseCase: LogoutUseCase { get }
}

public protocol LogoutUseCase: AutoMockable {
    func execute()
}

public struct LogoutUseCaseImpl: LogoutUseCase {
    
    @Injected private var authTokenRepository: AuthTokenRepository
    
    public func execute() {
        authTokenRepository.delete()
    }
}
