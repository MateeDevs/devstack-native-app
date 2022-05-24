//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer
import Foundation

public class DatabaseProviderMock {
    
    public var readObjectCallsCount = 0
    public var readObjectReturnValue: Any?
    
    public var readCollectionCallsCount = 0
    public var readCollectionReturnValue: [Any] = []
    
    public var updateObjectCallsCount = 0
    public var updateObjectReturnValue: Any?
    
    public var updateCollectionCallsCount = 0
    public var updateCollectionReturnValue: [Any] = []
    
    public var deleteObjectCallsCount = 0
    public var deleteCollectionCallsCount = 0
    public var deleteAllCallsCount = 0
    public var deleteAllExceptCallsCount = 0
    
    public init() {}
}

extension DatabaseProviderMock: DatabaseProvider {
    
    public func read<T>(_ type: T.Type, id: String) throws -> T {
        readObjectCallsCount += 1
        guard let returnValue = readObjectReturnValue as? T else { throw DatabaseProviderError.typeNotRepresentable }
        return returnValue
    }
    
    public func read<T>(_ type: T.Type, predicate: NSPredicate?, sortBy: String?, ascending: Bool) throws -> [T] {
        readCollectionCallsCount += 1
        guard let returnValue = readCollectionReturnValue as? [T] else { throw DatabaseProviderError.typeNotRepresentable }
        return returnValue
    }
    
    public func update<T>(_ object: T, model: UpdateModel) throws -> T {
        updateObjectCallsCount += 1
        guard let returnValue = updateObjectReturnValue as? T else { throw DatabaseProviderError.typeNotRepresentable }
        return returnValue
    }
    
    public func update<T>(_ objects: [T], model: UpdateModel) throws -> [T] {
        updateCollectionCallsCount += 1
        guard let returnValue = updateCollectionReturnValue as? [T] else { throw DatabaseProviderError.typeNotRepresentable }
        return returnValue
    }
    
    public func delete<T>(_ object: T) throws {
        deleteObjectCallsCount += 1
    }
    
    public func delete<T>(_ objects: [T]) throws {
        deleteCollectionCallsCount += 1
    }
    
    public func deleteAll() throws {
        deleteAllCallsCount += 1
    }
    
    public func deleteAll(except types: [Any.Type]) throws {
        deleteAllExceptCallsCount += 1
    }
}
