//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

struct NETAuthToken: Decodable {
    let userId: String
    let email: String
    let token: String
}

// Conversion from NetworkModel to DomainModel
extension NETAuthToken: DomainRepresentable {
    typealias DomainModel = AuthToken
    
    var domainModel: DomainModel {
        AuthToken(
            userId: userId,
            token: token
        )
    }
}
