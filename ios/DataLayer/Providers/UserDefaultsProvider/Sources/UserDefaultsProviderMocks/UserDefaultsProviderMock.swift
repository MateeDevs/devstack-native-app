//
//  Created by Petr Chmelar on 28.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import UserDefaultsProvider

public final class UserDefaultsProviderMock {
    
    public var readCallsCount = 0
    public var readReturnValue: Any?
    
    public var updateCallsCount = 0
    public var deleteCallsCount = 0
    public var deleteAllCallsCount = 0
}

extension UserDefaultsProviderMock: UserDefaultsProvider {
    
    public func read<T>(_ key: UserDefaultsCoding) throws -> T {
        readCallsCount += 1
        guard let returnValue = readReturnValue as? T else { throw UserDefaultsProviderError.valueForKeyNotFound }
        return returnValue
    }
    
    public func update<T>(_ key: UserDefaultsCoding, value: T) throws {
        updateCallsCount += 1
    }
    
    public func delete(_ key: UserDefaultsCoding) throws {
        deleteCallsCount += 1
    }
    
    public func deleteAll() throws {
        deleteAllCallsCount += 1
    }
}
