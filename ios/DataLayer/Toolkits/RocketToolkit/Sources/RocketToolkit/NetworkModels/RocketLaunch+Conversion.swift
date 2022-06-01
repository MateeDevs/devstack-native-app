//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain

// Conversion from NetworkModel to DomainModel
extension RocketLaunchListQuery.Data.Launch.Launch {
    var domainModel: RocketLaunch {
        RocketLaunch(
            id: id,
            site: site ?? ""
        )
    }
}
