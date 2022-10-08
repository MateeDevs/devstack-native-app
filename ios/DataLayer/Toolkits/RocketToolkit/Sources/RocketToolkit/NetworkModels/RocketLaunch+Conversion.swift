//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import ApolloAPI
import SharedDomain

// Conversion from NetworkModel to DomainModel
extension Rocket.RocketLaunchListQuery.Data.Launches.Launch {
    var domainModel: RocketLaunch {
        .init(
            id: id,
            site: site ?? ""
        )
    }
}
