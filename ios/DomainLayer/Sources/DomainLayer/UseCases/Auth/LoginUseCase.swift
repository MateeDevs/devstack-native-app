//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Resolver
import RxSwift

public protocol HasLoginUseCase {
    var loginUseCase: LoginUseCase { get }
}

public protocol LoginUseCase: AutoMockable {
    func execute(_ data: LoginData) -> Observable<Void>
}

public struct LoginUseCaseImpl: LoginUseCase {
    
    @Injected private var authTokenRepository: AuthTokenRepository
    
    public func execute(_ data: LoginData) -> Observable<Void> {
        authTokenRepository.create(data).mapToVoid()
    }
}
