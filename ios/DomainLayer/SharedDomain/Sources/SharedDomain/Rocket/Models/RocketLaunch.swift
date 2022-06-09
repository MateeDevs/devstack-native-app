//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public struct RocketLaunch: Equatable, Hashable {
    public let id: String
    public let site: String
    
    public init(
        id: String,
        site: String
    ) {
        self.id = id
        self.site = site
    }
}
