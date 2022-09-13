//
//  Created by Adam Penaz on 13.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation

public protocol ValidateLastNameUseCase {
    func execute(_ name: String) throws
}

public struct ValidateLastNameUseCaseImpl: ValidateLastNameUseCase {
    
    public init() {}
    
    public func execute(_ name: String) throws {
        if name.isEmpty {
            throw ValidationEditError.lastName(.isEmpty)
        }
        if name.count < 2 {
            throw ValidationEditError.lastName(.isInvalid)
        }
    }
}
