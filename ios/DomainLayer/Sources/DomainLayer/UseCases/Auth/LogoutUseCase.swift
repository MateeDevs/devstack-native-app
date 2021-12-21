//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol HasLogoutUseCase {
    var logoutUseCase: LogoutUseCase { get }
}

public protocol LogoutUseCase: AutoMockable {
    func execute()
}

public struct LogoutUseCaseImpl: LogoutUseCase {
    
    public typealias Dependencies = HasAuthTokenRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() {
        dependencies.authTokenRepository.delete()
    }
}
