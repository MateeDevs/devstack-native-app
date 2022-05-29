//
//  Created by Petr Chmelar on 28.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import RemoteConfigProvider

public final class RemoteConfigProviderMock: RemoteConfigProvider {

    public init() {}

    // MARK: - read

    public var readThrowableError: Error?
    public var readCallsCount = 0
    public var readCalled: Bool {
        return readCallsCount > 0
    }
    public var readReceivedKey: String?
    public var readReceivedInvocations: [String] = []
    public var readReturnValue: Bool!
    public var readClosure: ((String) async throws -> Bool)?

    public func read(_ key: String) async throws -> Bool {
        if let error = readThrowableError {
            throw error
        }
        readCallsCount += 1
        readReceivedKey = key
        readReceivedInvocations.append(key)
        if let readClosure = readClosure {
            return try await readClosure(key)
        } else {
            return readReturnValue
        }
    }

}
