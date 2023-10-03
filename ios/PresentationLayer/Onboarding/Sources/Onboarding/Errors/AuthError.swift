//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import SharedDomain
import UIToolkit

extension AuthError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .login(let reason):
            switch reason {
            case .invalidCredentials: L10n.invalid_credentials
            case .failed: L10n.signing_failed
            }
        case .registration(let reason):
            switch reason {
            case .userAlreadyExists: L10n.register_view_email_already_exists
            case .failed: L10n.signing_up_failed
            }
        }
    }
}
