//
//  Created by Petr Chmelar on 22.11.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public extension User {
    static let stub = User(
        id: "5c1a3d7b4a74580016faadf8",
        email: "petr.chmelar@matee.cz",
        firstName: "Petr",
        lastName: "Chmelar",
        phone: "112567",
        bio: "iOS dev",
        pictureUrl: "",
        counter: 0
    )
    
    static let stubList = [
        User(
            id: "5c1a3d7b4a74580016faadf8",
            email: "petr.chmelar@matee.cz",
            firstName: "Petr",
            lastName: "Chmelar",
            phone: "",
            bio: "",
            pictureUrl: "",
            counter: 0
        ),
        User(
            id: "5c50224464662000177f69a9",
            email: "user1@matee.cz",
            firstName: "User1",
            lastName: "Matee",
            phone: "",
            bio: "",
            pictureUrl: "",
            counter: 0
        )
    ]
}
