//
//  Created by Petr Chmelar on 29.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RealmSwift

public enum UpdateModel {
    case apiModel
    case fullModel
    
    func value(for object: Object) -> Any {
        switch self {
        case .apiModel: return object.apiModel
        case .fullModel: return object.fullModel
        }
    }
}
