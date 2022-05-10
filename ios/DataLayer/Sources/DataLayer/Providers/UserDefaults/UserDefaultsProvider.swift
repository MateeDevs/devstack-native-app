//
//  Created by Petr Chmelar on 14/10/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer

public enum UserDefaultsCoding: String, CaseIterable {
    case hasRunBefore
}

public protocol UserDefaultsProvider: AutoMockable {
    
    /// Try to read a value for the given key
    func read<T>(_ key: UserDefaultsCoding) -> T?

    /// Create or update the given key with a given value
    func update<T>(_ key: UserDefaultsCoding, value: T)

    /// Delete value for the given key
    func delete(_ key: UserDefaultsCoding)

    /// Delete all records
    func deleteAll()
}
