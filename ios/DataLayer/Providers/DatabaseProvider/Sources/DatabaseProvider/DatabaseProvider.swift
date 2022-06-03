//
//  Created by Petr Chmelar on 25.04.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation

public protocol DatabaseProvider {
    
    ///
    /// Generic function for reading a specified object from database.
    ///
    /// - parameter type: Type of object.
    /// - parameter id: Primary key to specify an object.
    /// - returns: A required object.
    ///
    func read<T>(_ type: T.Type, id: String) throws -> T
    
    ///
    /// Generic function for reading a specified collection of objects from database.
    ///
    /// - parameter type: Type of objects.
    /// - parameter predicate: NSPredicate for optional objects filtering.
    /// - parameter sortBy: Optional parameter for sorting.
    /// - parameter ascending: Optional parameter for sorting in ascending or descending order.
    /// - returns: An Array of required objects.
    ///
    func read<T>(_ type: T.Type, predicate: NSPredicate?, sortBy: String?, ascending: Bool) throws -> [T]
    
    ///
    /// Generic function that saves a given object.
    ///
    /// - parameter object: Object to be saved.
    /// - parameter model: Optional parameter to specify which parameters should be updated.
    /// - returns: A saved object.
    ///
    @discardableResult
    func update<T>(_ object: T, model: UpdateModel) throws -> T
    
    ///
    /// Generic function that saves a collection of objects.
    ///
    /// - parameter objects: Objects to be saved.
    /// - parameter model: Optional parameter to specify which parameters should be updated.
    /// - returns: An Array of saved objects.
    ///
    @discardableResult
    func update<T>(_ objects: [T], model: UpdateModel) throws -> [T]
    
    ///
    /// Generic function that deletes a given object.
    ///
    /// - parameter object: Object to be deleted.
    ///
    func delete<T>(_ object: T) throws
    
    ///
    /// Generic function that deletes a collection of objects.
    ///
    /// - parameter objects: Objects to be deleted
    ///
    func delete<T>(_ objects: [T]) throws
    
    /// Delete all records
    func deleteAll() throws
    
    /// Delete all records except specified types
    func deleteAll(except types: [Any.Type]) throws
}

// This extension exists only to provide default values for parameters
public extension DatabaseProvider {
    func read<T>(_ type: T.Type, predicate: NSPredicate? = nil, sortBy: String? = nil, ascending: Bool = true) throws -> [T] {
        try read(type, predicate: predicate, sortBy: sortBy, ascending: ascending)
    }
    
    @discardableResult
    func update<T>(_ object: T, model: UpdateModel = .apiModel) throws -> T {
        try update(object, model: model)
    }
    
    @discardableResult
    func update<T>(_ objects: [T], model: UpdateModel = .apiModel) throws -> [T] {
        try update(objects, model: model)
    }
}
