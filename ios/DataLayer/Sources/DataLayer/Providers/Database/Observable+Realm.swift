//
//  Created by Petr Chmelar on 07/08/2018.
//  Copyright © 2020 Matee. All rights reserved.
//

import RealmSwift
import RxSwift

extension ObservableType {
    
    /// Transformation that saves an object to the database.
    func save<T>(to provider: DatabaseProvider, model: UpdateModel = .apiModel) -> Observable<T> where T: Object, T == Element {
        flatMap { object -> Observable<T> in
            provider.save(object, model: model)
        }
    }
    
    /// Transformation that saves an array of objects to the database.
    func save<T>(to provider: DatabaseProvider, model: UpdateModel = .apiModel) -> Observable<[T]> where T: Object, [T] == Element {
        flatMap { objects -> Observable<[T]> in
            provider.save(objects, model: model)
        }
    }
}
