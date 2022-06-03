//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

// sourcery: AutoMockable
public protocol RemoteConfigProvider {
    /// Try to read a value for the given key
    func read(_ key: String) async throws -> Bool
}
