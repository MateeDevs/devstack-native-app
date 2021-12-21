//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol HasGetProfileIdUseCase {
    var getProfileIdUseCase: GetProfileIdUseCase { get }
}

public protocol GetProfileIdUseCase: AutoMockable {
    func execute() -> String?
}

public struct GetProfileIdUseCaseImpl: GetProfileIdUseCase {
    
    public typealias Dependencies = HasAuthTokenRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute() -> String? {
        dependencies.authTokenRepository.read()?.userId
    }
}
