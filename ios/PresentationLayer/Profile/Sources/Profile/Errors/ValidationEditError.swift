//
//  Created by Adam Penaz on 13.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import SharedDomain
import UIToolkit

extension ValidationEditError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .firstName(let reason):
            switch reason {
            case .isEmpty: return L10n.empty_first_name_fail
            case .isInvalid: return L10n.invalid_first_name
            }
        case .lastName(let reason):
            switch reason {
            case .isEmpty: return L10n.empty_last_name_fail
            case .isInvalid: return L10n.invalid_last_name
            }
        case .phone(let reason):
            switch reason {
            case .isEmpty: return L10n.empty_phone_fail
            case .isInvalid: return L10n.invalid_phone
            }
        }
    }
}
