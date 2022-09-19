//
//  Created by Adam Penaz on 19.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SharedDomain

public extension Weather {
    static let stub = Weather(
        conditionID: 1,
        cityName: "Prague",
        temperature: 25,
        units: .celsius
    )
}
