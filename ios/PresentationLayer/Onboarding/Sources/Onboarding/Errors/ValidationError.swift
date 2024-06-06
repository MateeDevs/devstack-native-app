//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import DevstackKmpShared
import SharedDomain
import UIToolkit

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .email(let reason):
            switch reason {
            #warning("TODO: Use MR strings when issue [https://github.com/icerockdev/moko-resources/issues/714] is resolved")
            case .isEmpty: "Invalid email format" // MR.strings().invalid_email.desc().localized()
            }
        case .password(let reason):
            switch reason {
            #warning("TODO: Use MR strings when issue [https://github.com/icerockdev/moko-resources/issues/714] is resolved")
            case .isEmpty: "Invalid password" // MR.strings().invalid_password.desc().localized()
            }
        }
    }
}
