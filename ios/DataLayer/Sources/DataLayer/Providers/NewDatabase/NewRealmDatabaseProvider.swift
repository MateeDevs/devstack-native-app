//
//  Created by Petr Chmelar on 25.04.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import RealmSwift

public struct NewRealmDatabaseProvider {
    
    public init() {
        setupMigration()
    }
    
    private func setupMigration() {
        // Realm BASIC migration setup
        var config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 0,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { _, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if oldSchemaVersion < 1 {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        // Delete old schema
        config.deleteRealmIfMigrationNeeded = true
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
}

extension NewRealmDatabaseProvider: NewDatabaseProvider {
    public func read<T>(_ type: T.Type, id: String) throws -> T {
        guard let realmType = T.self as? Object.Type else { throw CommonError.realmNotAvailable }
        let realm = try Realm()
        if let object = realm.object(ofType: realmType.self, forPrimaryKey: id) as? T {
            return object
        } else {
            throw CommonError.realmNotAvailable
        }
    }
    
    public func read<T>(_ type: T.Type, predicate: NSPredicate?, sortBy: String?, ascending: Bool) throws -> [T] {
        guard let realmType = T.self as? Object.Type else { throw CommonError.realmNotAvailable }
        
        let realm = try Realm()
        var realmObjects = realm.objects(realmType.self)
        
        if let predicate = predicate {
            realmObjects = realmObjects.filter(predicate)
        }
        
        if let sortBy = sortBy {
            realmObjects = realmObjects.sorted(byKeyPath: sortBy, ascending: ascending)
        }
        
        if let objects = realmObjects.toArray() as? [T] {
            return objects
        } else {
            throw CommonError.realmNotAvailable
        }
    }
    
    @discardableResult
    public func update<T>(_ object: T, model: UpdateModel) throws -> T {
        guard let realmObject = object as? Object else { throw CommonError.realmNotAvailable }
        let realm = try Realm()
        try realm.write {
            realm.create(type(of: realmObject).self, value: model.value(for: realmObject), update: .modified)
        }
        return object
    }
    
    @discardableResult
    public func update<T>(_ objects: [T], model: UpdateModel) throws -> [T] {
        try objects.forEach { object in
            try update(object, model: model)
        }
        return objects
    }
    
    public func deleteAll() throws {
        let realm = try Realm()
        try realm.write {
            realm.deleteAll()
        }
    }
}
