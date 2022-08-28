//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

public struct NetworkingConstants {
    public static var baseURL: String {
        switch Environment.type {
        case .alpha: return "https://devstack-server-production.up.railway.app"
        case .beta: return "https://devstack-server-production.up.railway.app"
        case .production: return "https://devstack-server-production.up.railway.app"
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
