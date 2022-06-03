//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public struct RegistrationData: Equatable {
    public let email: String
    public let password: String
    public let firstName: String
    public let lastName: String
    
    public init(
        email: String,
        password: String,
        firstName: String,
        lastName: String
    ) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
    }
}
