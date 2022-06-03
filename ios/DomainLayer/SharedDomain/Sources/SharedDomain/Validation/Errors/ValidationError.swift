//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public enum ValidationError: Error, Equatable {
    case email(Email)
    case password(Password)
    
    public enum Email {
        case isEmpty
    }
    
    public enum Password {
        case isEmpty
    }
}
