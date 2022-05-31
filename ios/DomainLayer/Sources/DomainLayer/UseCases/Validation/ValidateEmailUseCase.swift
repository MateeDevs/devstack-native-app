//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public protocol ValidateEmailUseCase: AutoMockable {
    func execute(_ email: String) throws
}

public struct ValidateEmailUseCaseImpl: ValidateEmailUseCase {
    
    public init() {}
    
    public func execute(_ email: String) throws {
        if email.isEmpty {
            throw ValidationError.email(.isEmpty)
        }
    }
}
