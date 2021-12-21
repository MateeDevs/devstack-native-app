//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasLoginUseCase {
    var loginUseCase: LoginUseCase { get }
}

public protocol LoginUseCase: AutoMockable {
    func execute(_ data: LoginData) -> Observable<Void>
}

public struct LoginUseCaseImpl: LoginUseCase {
    
    public typealias Dependencies = HasAuthTokenRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(_ data: LoginData) -> Observable<Void> {
        dependencies.authTokenRepository.create(data).mapToVoid()
    }
}
