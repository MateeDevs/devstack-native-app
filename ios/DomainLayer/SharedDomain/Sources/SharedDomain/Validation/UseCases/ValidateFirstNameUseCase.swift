//
//  Created by Adam Penaz on 13.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public protocol ValidateFirstNameUseCase {
    func execute(_ name: String) throws
}

public struct ValidateFirstNameUseCaseImpl: ValidateFirstNameUseCase {
    
    public init() {}
    
    public func execute(_ name: String) throws {
        if name.isEmpty {
            throw ValidationEditError.firstName(.isEmpty)
        }
        if name.count < 2 {
            throw ValidationEditError.firstName(.isInvalid)
        }
    }
}
