//
//  Created by Petr Chmelar on 25.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Spyable

@Spyable
public protocol ValidatePasswordUseCase {
    func execute(_ password: String) throws
}

public struct ValidatePasswordUseCaseImpl: ValidatePasswordUseCase {
    
    public init() {}
    
    public func execute(_ password: String) throws {
        if password.isEmpty {
            throw ValidationError.password(.isEmpty)
        }
    }
}
