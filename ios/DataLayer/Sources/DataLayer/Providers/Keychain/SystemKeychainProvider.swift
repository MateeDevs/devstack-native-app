//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import KeychainAccess
import Resolver

public struct SystemKeychainProvider {
    
    @Injected private var userDefaults: UserDefaultsProvider
    
    public init() {
        // Clear keychain on first run
        if (userDefaults.get(.hasRunBefore) as Bool?) == nil {
            deleteAll()
            userDefaults.save(.hasRunBefore, value: true)
        }
    }
}

extension SystemKeychainProvider: KeychainProvider {
    
    public func save(_ key: KeychainCoding, value: String) {
        guard let bundleId = Bundle.app.bundleIdentifier else { return }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        keychain[key.rawValue] = value
    }
    
    public func get(_ key: KeychainCoding) -> String? {
        guard let bundleId = Bundle.app.bundleIdentifier else { return nil }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        guard let value = keychain[key.rawValue] else { return nil }
        return value
    }
    
    public func delete(_ key: KeychainCoding) {
        guard let bundleId = Bundle.app.bundleIdentifier else { return }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        do {
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
