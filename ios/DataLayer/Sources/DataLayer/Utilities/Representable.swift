//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

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
