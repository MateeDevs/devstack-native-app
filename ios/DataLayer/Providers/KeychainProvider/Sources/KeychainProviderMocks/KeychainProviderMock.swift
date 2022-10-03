//
//  Created by Petr Chmelar on 28.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import KeychainProvider

public final class KeychainProviderMock: KeychainProvider {

    public init() {}

    // MARK: - read

    public var readThrowableError: Error?
    public var readCallsCount = 0
    public var readCalled: Bool {
        return readCallsCount > 0
    }
    public var readReceivedKey: KeychainCoding?
    public var readReceivedInvocations: [KeychainCoding] = []
    public var readReturnValue: String! // swiftlint:disable:this implicitly_unwrapped_optional
    public var readClosure: ((KeychainCoding) throws -> String)?

    public func read(_ key: KeychainCoding) throws -> String {
        if let error = readThrowableError {
            throw error
        }
        readCallsCount += 1
        readReceivedKey = key
        readReceivedInvocations.append(key)
        if let readClosure {
            return try readClosure(key)
        } else {
            return readReturnValue
        }
    }

    // MARK: - update

    public var updateValueThrowableError: Error?
    public var updateValueCallsCount = 0
    public var updateValueCalled: Bool {
        return updateValueCallsCount > 0
    }
    public var updateValueReceivedArguments: (key: KeychainCoding, value: String)?
    public var updateValueReceivedInvocations: [(key: KeychainCoding, value: String)] = []
    public var updateValueClosure: ((KeychainCoding, String) throws -> Void)?

    public func update(_ key: KeychainCoding, value: String) throws {
        if let error = updateValueThrowableError {
            throw error
        }
        updateValueCallsCount += 1
        updateValueReceivedArguments = (key: key, value: value)
        updateValueReceivedInvocations.append((key: key, value: value))
        try updateValueClosure?(key, value)
    }

    // MARK: - delete

    public var deleteThrowableError: Error?
    public var deleteCallsCount = 0
    public var deleteCalled: Bool {
        return deleteCallsCount > 0
    }
    public var deleteReceivedKey: KeychainCoding?
    public var deleteReceivedInvocations: [KeychainCoding] = []
    public var deleteClosure: ((KeychainCoding) throws -> Void)?

    public func delete(_ key: KeychainCoding) throws {
        if let error = deleteThrowableError {
            throw error
        }
        deleteCallsCount += 1
        deleteReceivedKey = key
        deleteReceivedInvocations.append(key)
        try deleteClosure?(key)
    }

    // MARK: - deleteAll

    public var deleteAllThrowableError: Error?
    public var deleteAllCallsCount = 0
    public var deleteAllCalled: Bool {
        return deleteAllCallsCount > 0
    }
    public var deleteAllClosure: (() throws -> Void)?

    public func deleteAll() throws {
        if let error = deleteAllThrowableError {
            throw error
        }
        deleteAllCallsCount += 1
        try deleteAllClosure?()
    }

}
