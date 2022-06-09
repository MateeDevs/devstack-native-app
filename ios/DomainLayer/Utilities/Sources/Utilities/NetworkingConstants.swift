//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public struct NetworkingConstants {
    public static var baseURL: String {
        switch Environment.type {
        case .alpha: return "https://matee-devstack.herokuapp.com"
        case .beta: return "https://matee-devstack.herokuapp.com"
        case .production: return "https://matee-devstack.herokuapp.com"
        }
    }
    
    public static var rocketsURL: String {
        switch Environment.type {
        case .alpha: return "https://apollo-fullstack-tutorial.herokuapp.com/graphql"
        case .beta: return "https://apollo-fullstack-tutorial.herokuapp.com/graphql"
        case .production: return "https://apollo-fullstack-tutorial.herokuapp.com/graphql"
        }
    }
}
