//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer

struct NetworkingConstants {

    static let apiVersion = 1
    
    static let iso8601DefaultFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    static let iso8601DateOnly = "yyyy-MM-dd"
    
    static var baseURL: String {
        switch Environment.type {
        case .alpha: return "https://matee-devstack.herokuapp.com"
        case .beta: return "https://matee-devstack.herokuapp.com"
        case .production: return "https://matee-devstack.herokuapp.com"
        }
    }
}
