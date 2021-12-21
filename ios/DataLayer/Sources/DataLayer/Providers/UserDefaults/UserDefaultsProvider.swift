//
//  Created by Petr Chmelar on 14/10/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer

public protocol HasUserDefaultsProvider {
    var userDefaultsProvider: UserDefaultsProvider { get }
}

public enum UserDefaultsCoding: String, CaseIterable {
    case hasRunBefore
}

public protocol UserDefaultsProvider: AutoMockable {

    /// Save the given key/value combination
    func save<T>(_ key: UserDefaultsCoding, value: T)

    /// Try to retrieve a value for the given key
    func get<T>(_ key: UserDefaultsCoding) -> T?

    /// Delete value for the given key
    func delete(_ key: UserDefaultsCoding)

    /// Delete all records
    func deleteAll()
}
