//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain

public extension RocketLaunch {
    static let stub = RocketLaunch(
        id: "1",
        site: "Cape Canaveral"
    )
}

public extension Array where Element == RocketLaunch {
    static let stub = [
        RocketLaunch(
            id: "1",
            site: "Cape Canaveral"
        ),
        RocketLaunch(
            id: "2",
            site: "Baikonur"
        )
    ]
}
