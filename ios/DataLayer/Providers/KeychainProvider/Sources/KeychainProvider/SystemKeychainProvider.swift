//
//  Created by Petr Chmelar on 01/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import KeychainAccess
import OSLog

public struct SystemKeychainProvider {
    public init() {}
}

extension SystemKeychainProvider: KeychainProvider {
    
    public func read(_ key: KeychainCoding) throws -> String {
        guard let bundleId = Bundle.app.bundleIdentifier else { throw KeychainProviderError.invalidBundleIdentifier }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        guard let value = keychain[key.rawValue] else { throw KeychainProviderError.valueForKeyNotFound }
        return value
    }
    
    public func update(_ key: KeychainCoding, value: String) throws {
        guard let bundleId = Bundle.app.bundleIdentifier else { throw KeychainProviderError.invalidBundleIdentifier }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        keychain[key.rawValue] = value
    }
    
    public func delete(_ key: KeychainCoding) throws {
        guard let bundleId = Bundle.app.bundleIdentifier else { throw KeychainProviderError.invalidBundleIdentifier }
        let keychain = Keychain(service: bundleId, accessGroup: "group.\(bundleId)")
        try keychain.remove(key.rawValue)
    }
    
    public func deleteAll() throws {
        for key in KeychainCoding.allCases {
            try delete(key)
        }
    }
}
