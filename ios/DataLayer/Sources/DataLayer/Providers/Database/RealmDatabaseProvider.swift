//
//  Created by Petr Chmelar on 14/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import RealmSwift
import RxRealm
import RxSwift

public struct RealmDatabaseProvider {
    
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

extension RealmDatabaseProvider: DatabaseProvider {
    
    public func observableObject<T>(
        _ type: T.Type,
        id: String,
        primaryKeyName: String
    ) -> Observable<T> where T: Object {
        guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
        let dbObjects = realm.objects(T.self).filter(NSPredicate(format: "\(primaryKeyName) == %@", id))
        
        return Observable.collection(from: dbObjects).flatMap { objects -> Observable<T> in
            guard let object = objects.first else { return .empty() }
            return .just(object)
        }
    }
    
    public func observableCollection<T>(
        _ type: T.Type,
        predicate: NSPredicate?,
        sortBy: String?,
        ascending: Bool
    ) -> Observable<[T]> where T: Object {
        guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
        var dbObjects = realm.objects(T.self)
        
        if let predicate = predicate {
            dbObjects = dbObjects.filter(predicate)
        }
        
        if let sortBy = sortBy {
            dbObjects = dbObjects.sorted(byKeyPath: sortBy, ascending: ascending)
        }
        
        return Observable.array(from: dbObjects).flatMap { objects -> Observable<[T]> in
            guard !objects.isEmpty else { return .just([]) }
            return .just(objects)
        }
    }
    
    public func save<T>(_ object: T, model: UpdateModel) -> Observable<T> where T: Object {
        guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
        return .create { observer in
            do {
                try realm.write {
                    realm.create(T.self, value: model.value(for: object), update: .modified)
                }
                observer.onNext(object)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    public func save<T>(_ objects: [T], model: UpdateModel) -> Observable<[T]> where T: Object {
        guard let realm = Realm.safeInit() else { return .error(CommonError.realmNotAvailable) }
        return .create { observer in
            do {
                try realm.write {
                    for object in objects {
                        realm.create(T.self, value: model.value(for: object), update: .modified)
                    }
                }
                observer.onNext(objects)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    public func deleteAll() {
        guard let realm = Realm.safeInit() else { return }
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            Logger.error("Error during Realm deleteAll operation:\n%@", "\(error)", category: .app)
        }
    }
}
