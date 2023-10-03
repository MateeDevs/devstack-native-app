//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import NetworkProvider
import Utilities

enum UserAPI {
    case list(_ page: Int)
    case read(_ id: String)
    case update(_ id: String, data: [String: Any])
}

extension UserAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: "\(NetworkingConstants.baseURL)/api")! }
    var path: String {
        switch self {
        case .list: "/user"
        case let .read(id): "/user/\(id)"
        case let .update(id, _): "/user/\(id)"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .update: .put
        default: .get
        }
    }
    var headers: [String: String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case let .list(page): .requestParameters(
            parameters: ["page": page, "limit": 100],
            encoding: URLEncoding.default
        )
        case let .update(_, data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        default: .requestPlain
        }
    }
}
