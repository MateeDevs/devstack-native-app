//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer

public protocol HasKeychainProvider {
    var keychainProvider: KeychainProvider { get }
}

public enum KeychainCoding: String, CaseIterable {
    case authToken
    case userId
}

public protocol KeychainProvider: AutoMockable {

    /// Save the given key/value combination
    func save(_ key: KeychainCoding, value: String)

    /// Try to retrieve a value for the given key
    func get(_ key: KeychainCoding) -> String?

    /// Delete value for the given key
    func delete(_ key: KeychainCoding)

    /// Delete all records
    func deleteAll()
}
