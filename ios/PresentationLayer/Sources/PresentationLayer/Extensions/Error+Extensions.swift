//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Foundation

extension Swift.Error {
    
    ///
    /// Transformation that tries to map an error to a message based on a given ruleset
    ///
    /// - parameter messages: Ruleset that define messages for status codes
    /// - returns: Error message
    ///
    func toString(_ messages: ErrorMessages) -> String {
        if let validationError = self as? ValidationError {
            return validationError.localizedDescription
        } else if let repositoryError = self as? RepositoryError,
            let message = messages.statusCodes.first(where: { $0.key == repositoryError.statusCode })?.value {
            return message
        } else {
            return messages.defaultMessage
        }
    }
}
