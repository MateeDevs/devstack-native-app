//
//  Created by Petr Chmelar on 16.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Foundation

extension AuthError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidEmail: return L10n.invalid_email
        case .invalidPassword: return L10n.invalid_password
        case .invalidCredentials: return L10n.invalid_credentials
        case .failed: return L10n.signing_failed
        }
    }
}
