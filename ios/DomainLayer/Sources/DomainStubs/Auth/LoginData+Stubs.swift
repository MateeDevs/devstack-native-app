//
//  Created by Petr Chmelar on 19.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public extension LoginData {
    static let stubEmpty = LoginData(email: "", password: "")
    static let stubValid = LoginData(email: "email@email.com", password: "validPassword")
    static let stubInvalidPassword = LoginData(email: "email@email.com", password: "invalidPassword")
}
