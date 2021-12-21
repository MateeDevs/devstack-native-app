//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

public protocol HasDatabaseProvider {
    var databaseProvider: DatabaseProvider { get }
}

public protocol DatabaseProvider {
    
    ///
    /// Generic function for observing on a specified object from database.
    ///
    /// - parameter type: Type of object.
    /// - parameter id: Primary key to specify an object.
    /// - parameter primaryKeyName: Optional parameter to set alternate primary key name (default is "id").
    /// - returns: Observable which emits a required object.
    ///
    func observableObject<T>(
        _ type: T.Type,
        id: String,
        primaryKeyName: String
    ) -> Observable<T> where T: Object
    
    ///
    /// Generic function for observing on a specified collection of objects from database.
    ///
    /// - parameter type: Type of objects.
    /// - parameter predicate: NSPredicate for optional objects filtering.
    /// - parameter sortBy: Optional parameter for sorting.
    /// - parameter ascending: Optional parameter for sorting in ascending or descending order.
    /// - returns: Observable which emits an Array of required objects.
    ///
    func observableCollection<T>(
        _ type: T.Type,
        predicate: NSPredicate?,
        sortBy: String?,
        ascending: Bool
    ) -> Observable<[T]> where T: Object
    
    ///
    /// Generic function that saves a given object.
    ///
    /// - parameter object: Object to be saved.
    /// - parameter model: Optional parameter to specify which parameters should be updated.
    /// - returns: Observable which emits an saved object.
    ///
    func save<T>(_ object: T, model: UpdateModel) -> Observable<T> where T: Object
    
    ///
    /// Generic function that saves a collection of objects.
    ///
    /// - parameter objects: Objects to be saved.
    /// - parameter model: Optional parameter to specify which parameters should be updated.
    /// - returns: Observable which emits an Array of saved objects.
    ///
    func save<T>(_ objects: [T], model: UpdateModel) -> Observable<[T]> where T: Object
    
    /// Delete all records
    func deleteAll()
}

// This extension exists only to provide default values for parameters
extension DatabaseProvider {
    
    func observableObject<T>(
        _ type: T.Type,
        id: String,
        primaryKeyName: String = "id"
    ) -> Observable<T> where T: Object {
        observableObject(type, id: id, primaryKeyName: primaryKeyName)
    }
    
    func observableCollection<T>(
        _ type: T.Type,
        predicate: NSPredicate? = nil,
        sortBy: String? = nil,
        ascending: Bool = true
    ) -> Observable<[T]> where T: Object {
        observableCollection(type, predicate: predicate, sortBy: sortBy, ascending: ascending)
    }
    
    func save<T>(_ object: T, model: UpdateModel = .apiModel) -> Observable<T> where T: Object {
        save(object, model: model)
    }
    
    func save<T>(_ objects: [T], model: UpdateModel = .apiModel) -> Observable<[T]> where T: Object {
        save(objects, model: model)
    }
}
