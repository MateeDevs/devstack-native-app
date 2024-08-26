//
//  Created by Tomáš Batěk on 24.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation

public protocol DomainRepresentable {
    associatedtype DomainModel
    
    var domainModel: DomainModel { get throws }
}

public protocol NetworkRepresentable {
    associatedtype NetworkModel
    
    var networkModel: NetworkModel { get throws }
}
