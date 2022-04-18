//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Foundation

enum UserAPI {
    case readUsersForPage(_ page: Int)
    case readUserById(_ id: String)
    case updateUserById(_ id: String, data: [String: Any])
}

extension UserAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: "\(NetworkingConstants.baseURL)/api")! }
    var path: String {
        switch self {
        case .readUsersForPage:
            return "/user"
        case let .readUserById(id):
            return "/user/\(id)"
        case let .updateUserById(id, _):
            return "/user/\(id)"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .updateUserById:
            return .put
        default:
            return .get
        }
    }
    var headers: [String: String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case let .readUsersForPage(page):
            let params: [String: Any] = [
                "page": page,
                "limit": Constants.paginationCount
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case let .updateUserById(_, data):
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .readUsersForPage:
            return NETUser.stubList
        case .readUserById, .updateUserById:
            return NETUser.stub
        }
    }
}
