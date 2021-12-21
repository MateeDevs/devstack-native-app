//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

struct NETLoginData: Encodable {
    let email: String
    let pass: String
}

// Conversion from DomainModel to NetworkModel
extension LoginData: NetworkRepresentable {
    typealias NetworkModel = NETLoginData
    
    var networkModel: NetworkModel {
        NETLoginData(
            email: email,
            pass: password
        )
    }
}
