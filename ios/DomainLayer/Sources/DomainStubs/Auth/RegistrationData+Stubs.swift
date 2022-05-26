//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public extension RegistrationData {
    static let stubValid = RegistrationData(
        email: "email@email.com",
        password: "password",
        firstName: "Anonymous",
        lastName: ""
    )
    
    static let stubEmptyEmail = RegistrationData(
        email: "",
        password: "password",
        firstName: "Anonymous",
        lastName: ""
    )
    
    static let stubEmptyPassword = RegistrationData(
        email: "email@email.com",
        password: "",
        firstName: "Anonymous",
        lastName: ""
    )
    
    static let stubExistingEmail = RegistrationData(
        email: "existing@email.com",
        password: "password",
        firstName: "Anonymous",
        lastName: ""
    )
}
