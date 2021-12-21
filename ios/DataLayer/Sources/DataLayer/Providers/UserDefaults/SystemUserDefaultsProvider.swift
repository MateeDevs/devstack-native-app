//
//  Created by Petr Chmelar on 14/10/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

public struct SystemUserDefaultsProvider {
    public init() {}
}

extension SystemUserDefaultsProvider: UserDefaultsProvider {
    
    public func save<T>(_ key: UserDefaultsCoding, value: T) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    public func get<T>(_ key: UserDefaultsCoding) -> T? {
        UserDefaults.standard.object(forKey: key.rawValue) as? T
    }
    
    public func delete(_ key: UserDefaultsCoding) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    public func deleteAll() {
        for key in UserDefaultsCoding.allCases {
            delete(key)
        }
    }
}
