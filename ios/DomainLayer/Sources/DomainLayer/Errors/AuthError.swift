//
//  Created by Petr Chmelar on 16.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public enum AuthError: Error {
    case notLogged
    case login(Login)
    case registration(Registration)
    
    public enum Login: Error {
        case invalidCredentials
        case failed
    }
    
    public enum Registration: Error {
        case userAlreadyExists
        case failed
    }
}
