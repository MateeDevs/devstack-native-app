//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

protocol DomainRepresentable {
    associatedtype DomainModel
    
    var domainModel: DomainModel { get }
}

protocol DatabaseRepresentable {
    associatedtype DatabaseModel
    
    var databaseModel: DatabaseModel { get }
}

protocol NetworkRepresentable {
    associatedtype NetworkModel
    
    var networkModel: NetworkModel { get }
}

extension ObservableType {
    func mapToDomain<T>() -> Observable<T.DomainModel>
    where T: DomainRepresentable, T == Element {
        map { $0.domainModel }
    }
    
    func mapToDomain<T>() -> Observable<[T.DomainModel]>
    where T: DomainRepresentable, [T] == Element {
        map { $0.map { $0.domainModel } }
    }
    
    func mapToDatabase<T>() -> Observable<T.DomainModel.DatabaseModel>
    where T: DomainRepresentable, T.DomainModel: DatabaseRepresentable, T == Element {
        map { $0.domainModel.databaseModel }
    }
    
    func mapToDatabase<T>() -> Observable<[T.DomainModel.DatabaseModel]>
    where T: DomainRepresentable, T.DomainModel: DatabaseRepresentable, [T] == Element {
        map { $0.map { $0.domainModel.databaseModel } }
    }
}
