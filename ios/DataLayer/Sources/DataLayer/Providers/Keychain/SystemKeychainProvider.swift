//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import KeychainAccess

public struct SystemKeychainProvider {
    
    public init(userDefaultsProvider: UserDefaultsProvider) {
        // Clear keychain on first run
        if (userDefaultsProvider.get(.hasRunBefore) as Bool?) == nil {
            deleteAll()
            userDefaultsProvider.save(.hasRunBefore, value: true)
        }
    }
}

extension SystemKeychainProvider: KeychainProvider {
    
    public func save(_ key: KeychainCoding, value: String) {
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        keychain[key.rawValue] = value
    }
    
    public func get(_ key: KeychainCoding) -> String? {
        let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
        guard let value = keychain[key.rawValue] else { return nil }
        return value
    }
    
    public func delete(_ key: KeychainCoding) {
        do {
            let keychain = Keychain(service: "\(Bundle.main.bundleIdentifier!)")
            try keychain.remove(key.rawValue)
        } catch let error {
            Logger.error("Error during KeychainStore delete operation:\n%@", "\(error)", category: .app)
        }
    }
    
    public func deleteAll() {
        for key in KeychainCoding.allCases {
            delete(key)
        }
    }
}
