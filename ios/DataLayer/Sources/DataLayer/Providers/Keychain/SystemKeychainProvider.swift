//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import KeychainAccess
import OSLog

public struct SystemKeychainProvider {
    
    public init(userDefaultsProvider: UserDefaultsProvider) {
        // Clear keychain on first run
        if (userDefaultsProvider.read(.hasRunBefore) as Bool?) == nil {
            deleteAll()
            userDefaultsProvider.update(.hasRunBefore, value: true)
        }
    }
}

extension SystemKeychainProvider: KeychainProvider {
    
    public func read(_ key: KeychainCoding) -> String? {
        guard let bundleId = Bundle.app.bundleIdentifier else { return nil }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        guard let value = keychain[key.rawValue] else { return nil }
        return value
    }
    
    public func update(_ key: KeychainCoding, value: String) {
        guard let bundleId = Bundle.app.bundleIdentifier else { return }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        keychain[key.rawValue] = value
    }
    
    public func delete(_ key: KeychainCoding) {
        guard let bundleId = Bundle.app.bundleIdentifier else { return }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        do {
            try keychain.remove(key.rawValue)
        } catch let error {
            Logger.app.error("Error during KeychainStore delete operation:\n\(error.localizedDescription)")
        }
    }
    
    public func deleteAll() {
        for key in KeychainCoding.allCases {
            delete(key)
        }
    }
}
