//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public extension LoginData {
    static let stubValid = LoginData(email: "email@email.com", password: "password")
    static let stubEmptyEmail = LoginData(email: "", password: "password")
    static let stubEmptyPassword = LoginData(email: "email@email.com", password: "")
    static let stubInvalidPassword = LoginData(email: "email@email.com", password: "invalidPassword")
}
