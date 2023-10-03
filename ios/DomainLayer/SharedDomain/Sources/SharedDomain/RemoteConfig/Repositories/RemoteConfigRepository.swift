//
//  Created by Petr Chmelar on 08.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Spyable

@Spyable
public protocol RemoteConfigRepository {
    func read(_ key: RemoteConfigCoding) async throws -> Bool
}
