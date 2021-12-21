//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DataLayer
import Foundation
import RealmSwift
import RxSwift

public class DatabaseProviderMock: DatabaseProvider {
    
    public var observableObjectCallsCount = 0
    public var observableObjectReturnValue: Object?
    
    public var observableCollectionCallsCount = 0
    public var observableCollectionReturnValue: [Object] = []
    
    public var saveObjectCallsCount = 0
    public var saveCollectionCallsCount = 0
    public var deleteAllCallsCount = 0
    
    public init() {}

    public func observableObject<T>(
        _ type: T.Type,
        id: String,
        primaryKeyName: String
    ) -> Observable<T> where T: Object {
        guard let object = observableObjectReturnValue as? T else { return .empty() }
        return Observable.just(object).do { _ in self.observableObjectCallsCount += 1 }
    }

    public func observableCollection<T>(
        _ type: T.Type,
        predicate: NSPredicate?,
        sortBy: String?,
        ascending: Bool
    ) -> Observable<[T]> where T: Object {
        guard let collection = observableCollectionReturnValue as? [T] else { return .empty() }
        return Observable.just(collection).do { _ in self.observableCollectionCallsCount += 1 }
    }
    
    public func save<T>(_ object: T, model: UpdateModel) -> Observable<T> where T: Object {
        return Observable.just(object).do { _ in self.saveObjectCallsCount += 1 }
    }
    
    public func save<T>(_ objects: [T], model: UpdateModel) -> Observable<[T]> where T: Object {
        return Observable.just(objects).do { _ in self.saveCollectionCallsCount += 1 }
    }

    public func deleteAll() {
        deleteAllCallsCount += 1
    }
}
