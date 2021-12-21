//
//  Created by Petr Chmelar on 10.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation

enum Flow {
    case login(Login)
    case registration(Registration)
    case users(Users)
    case books(Books)
    case profile(Profile)
}
