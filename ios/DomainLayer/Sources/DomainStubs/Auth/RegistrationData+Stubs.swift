//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public extension RegistrationData {
    static let stubEmpty = RegistrationData(
        email: "",
        password: "",
        firstName: "",
        lastName: ""
    )
    
    static let stubValid = RegistrationData(
        email: "email@email.com",
        password: "validPassword",
        firstName: "Anonymous",
        lastName: ""
    )
    
    static let stubInvalidEmail = RegistrationData(
        email: "invalidEmail",
        password: "validPassword",
        firstName: "Anonymous",
        lastName: ""
    )
    
    static let stubExistingEmail = RegistrationData(
        email: "existing@email.com",
        password: "validPassword",
        firstName: "Anonymous",
        lastName: ""
    )
}
