//
//  Created by Petr Chmelar on 14/10/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import Foundation

public struct SystemUserDefaultsProvider {
    public init() {}
}

extension SystemUserDefaultsProvider: UserDefaultsProvider {
    
    public func save<T>(_ key: UserDefaultsCoding, value: T) {
        guard let bundleId = Bundle.app.bundleIdentifier, let defaults = UserDefaults(suiteName: "group.\(bundleId)") else { return }
        defaults.set(value, forKey: key.rawValue)
    }
    
    public func get<T>(_ key: UserDefaultsCoding) -> T? {
        guard let bundleId = Bundle.app.bundleIdentifier, let defaults = UserDefaults(suiteName: "group.\(bundleId)") else { return nil }
        return defaults.object(forKey: key.rawValue) as? T
    }
    
    public func delete(_ key: UserDefaultsCoding) {
        guard let bundleId = Bundle.app.bundleIdentifier, let defaults = UserDefaults(suiteName: "group.\(bundleId)") else { return }
        defaults.removeObject(forKey: key.rawValue)
    }
    
    public func deleteAll() {
        for key in UserDefaultsCoding.allCases {
            delete(key)
        }
    }
}
