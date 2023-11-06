//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public enum KeychainCoding: String, CaseIterable {
    case authToken
    case userId
}

public protocol KeychainProvider {
    
    /// Try to read a value for the given key
    func read(_ key: KeychainCoding) throws -> String

    /// Create or update the given key with a given value
    func update(_ key: KeychainCoding, value: String) throws

    /// Delete value for the given key
    func delete(_ key: KeychainCoding) throws

    /// Delete all records
    func deleteAll() throws
}
