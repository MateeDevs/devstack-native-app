//
//  Created by Petr Chmelar on 14/10/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

public struct SystemUserDefaultsProvider {
    public init() {}
}

extension SystemUserDefaultsProvider: UserDefaultsProvider {
    
    public func read<T>(_ key: UserDefaultsCoding) throws -> T {
        guard let bundleId = Bundle.app.bundleIdentifier, let defaults = UserDefaults(suiteName: "group.\(bundleId)") else {
            throw UserDefaultsProviderError.invalidBundleIdentifier
        }
        guard let object = defaults.object(forKey: key.rawValue) as? T else {
            throw UserDefaultsProviderError.valueForKeyNotFound
        }
        return object
    }
    
    public func update<T>(_ key: UserDefaultsCoding, value: T) throws {
        guard let bundleId = Bundle.app.bundleIdentifier, let defaults = UserDefaults(suiteName: "group.\(bundleId)") else {
            throw UserDefaultsProviderError.invalidBundleIdentifier
        }
        defaults.set(value, forKey: key.rawValue)
    }
    
    public func delete(_ key: UserDefaultsCoding) throws {
        guard let bundleId = Bundle.app.bundleIdentifier, let defaults = UserDefaults(suiteName: "group.\(bundleId)") else {
            throw UserDefaultsProviderError.invalidBundleIdentifier
        }
        defaults.removeObject(forKey: key.rawValue)
    }
    
    public func deleteAll() throws {
        for key in UserDefaultsCoding.allCases {
            try delete(key)
        }
    }
}
