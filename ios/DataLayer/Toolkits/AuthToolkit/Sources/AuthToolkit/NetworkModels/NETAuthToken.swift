//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import SharedDomain

struct NETAuthToken: Decodable {
    let userId: String
    let email: String
    let token: String
}

// Conversion from NetworkModel to DomainModel
extension NETAuthToken {
    var domainModel: AuthToken {
        AuthToken(
            userId: userId,
            token: token
        )
    }
}
