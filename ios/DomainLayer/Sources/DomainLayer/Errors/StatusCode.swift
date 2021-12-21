//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public enum StatusCode: Int {
    case unknown = 0
    
    // Codes 100 - 599 are reserved for HTTP status codes
    case httpBadRequest = 400
    case httpUnathorized = 401
    case httpForbidden = 403
    case httpNotFound = 404
    case httpMethodNotAllowed = 405
    case httpConflict = 409
    case httpInternalServerError = 500
    
    case networkError = 900
    case databaseError = 901
    case fileError = 902
    case userDefaultsError = 903
    case keychainError = 904
}
