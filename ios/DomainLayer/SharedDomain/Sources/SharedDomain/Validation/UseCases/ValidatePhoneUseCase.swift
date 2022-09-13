//
//  Created by Adam Penaz on 13.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation

public protocol ValidatePhoneUseCase {
    func execute(_ phone: String) throws
}

public struct ValidatePhoneUseCaseImpl: ValidatePhoneUseCase {
    
    public init() {}
    
    public func execute(_ phone: String) throws {
        if phone.isEmpty {
            throw ValidationEditError.phone(.isEmpty)
        }
        
        let phoneRegex = #"^(\+?420)?(2[0-9]{2}|3[0-9]{2}|4[0-9]{2}|5[0-9]{2}|72[0-9]|73[0-9]|77[0-9]|60[1-8]|56[0-9]|70[2-5]|79[0-9])[0-9]{3}[0-9]{3}$"#
        let result = phone.components(separatedBy: .whitespacesAndNewlines).joined().range(
            of: phoneRegex,
            options: .regularExpression
        )
        if result == nil {
            throw ValidationEditError.phone(.isInvalid)
        }
    }
}
