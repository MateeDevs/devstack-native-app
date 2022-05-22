//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Foundation

extension AuthError.Login: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidCredentials: return L10n.invalid_credentials
        case .failed: return L10n.signing_failed
        }
    }
}

extension AuthError.Registration: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userAlreadyExists: return L10n.register_view_email_already_exists
        case .failed: return L10n.signing_up_failed
        }
    }
}
