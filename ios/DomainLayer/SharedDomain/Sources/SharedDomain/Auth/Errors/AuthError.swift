//
//  Created by Petr Chmelar on 16.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public enum AuthError: Error, Equatable {
    case login(Login)
    case registration(Registration)
    
    public enum Login {
        case invalidCredentials
        case failed
    }
    
    public enum Registration {
        case userAlreadyExists
        case failed
    }
}
