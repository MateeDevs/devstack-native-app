//
//  Created by Tomáš Batěk on 28.04.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import DevstackKmpShared
import SharedDomain

extension KMMError: LocalizedError {
    public var errorDescription: String? {
        if let errorResult {
            errorResultDescription(errorResult)
        } else if let throwable {
            throwableDescription(throwable)
        }
        return L10n.unknown_error
    }
    
    private func errorResultDescription(_ errorResult: ErrorResult) -> String? {
        switch errorResult {
        // CommonError
        case is DevstackKmpShared.CommonError.NoNetworkConnection: return L10n.error_no_internet_connection
            
        // AuthError
        case is DevstackKmpShared.AuthError.InvalidLoginCredentials: return L10n.invalid_credentials
        case is DevstackKmpShared.AuthError.EmailAlreadyExist: return L10n.register_view_email_already_exists
            
        default: return L10n.unknown_error
        }
    }
    
    private func throwableDescription(_ throwable: KotlinThrowable) -> String? {
        // TODO: Handling Kotlin throwables?
        return L10n.unknown_error
    }
}


