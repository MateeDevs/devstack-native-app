//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public protocol RemoteConfigProvider: AutoMockable {
    /// Try to read a value for the given key
    func read(_ key: RemoteConfigCoding) async throws -> Bool
}
