//
//  Created by Petr Chmelar on 08.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation
import RxSwift

public enum SourceType {
    case local
    case remote
    case both
    
    public func result<T>(db: Observable<T>, net: Observable<T>) -> Observable<T> {
        switch self {
        case .local: return db
        case .remote: return net
        case .both: return .merge(db, net.mapToEmpty())
        }
    }
}
