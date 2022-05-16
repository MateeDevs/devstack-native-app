//
//  Created by Petr Chmelar on 16.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Foundation

extension AuthError {
    init(_ error: Error) {
        switch error {
        case let NetworkProviderError.requestFailed(statusCode, _) where statusCode == .unathorized:
            self = .invalidCredentials
        default:
            self = .failed
        }
    }
}