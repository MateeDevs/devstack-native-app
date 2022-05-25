//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Foundation

extension AuthError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .login(let reason):
            switch reason {
            case .invalidCredentials: return L10n.invalid_credentials
            case .failed: return L10n.signing_failed
            }
        case .registration(let reason):
            switch reason {
            case .userAlreadyExists: return L10n.register_view_email_already_exists
            case .failed: return L10n.signing_up_failed
            }
        default:
            return L10n.unknown_error
        }
    }
}
