//
//  Created by Petr Chmelar on 16.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public enum AuthError: Error, Equatable {
    case registration(Registration)
    
    public enum Registration {
        case userAlreadyExists
        case failed
    }
}
