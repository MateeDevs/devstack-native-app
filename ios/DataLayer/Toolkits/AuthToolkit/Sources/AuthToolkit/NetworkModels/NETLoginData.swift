//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain

struct NETLoginData: Encodable {
    let email: String
    let pass: String
}

// Conversion from DomainModel to NetworkModel
extension LoginData {
    var networkModel: NETLoginData {
        NETLoginData(
            email: email,
            pass: password
        )
    }
}
