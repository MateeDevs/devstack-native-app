//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Spyable

@Spyable
public protocol ValidateEmailUseCase {
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
