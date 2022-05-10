//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer

public enum KeychainCoding: String, CaseIterable {
    case authToken
    case userId
}

public protocol KeychainProvider: AutoMockable {
    
    /// Try to read a value for the given key
    func read(_ key: KeychainCoding) -> String?

    /// Create or update the given key with a given value
    func update(_ key: KeychainCoding, value: String)

    /// Delete value for the given key
    func delete(_ key: KeychainCoding)

    /// Delete all records
    func deleteAll()
}
