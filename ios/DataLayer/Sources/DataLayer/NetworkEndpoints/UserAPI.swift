//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import Moya

enum UserAPI {
    case getUsersForPage(_ page: Int)
    case getUserById(_ id: String)
    case updateUserById(_ id: String, data: [String: Any])
}

extension UserAPI: TargetType {
    var baseURL: URL { URL(string: "\(NetworkingConstants.baseURL)/api")! }
    var path: String {
        switch self {
        case .getUsersForPage:
            return "/user"
        case .getUserById(let id):
            return "/user/\(id)"
        case .updateUserById(let id, _):
            return "/user/\(id)"
        }
    }
    var method: Moya.Method {
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
    var task: Task {
        switch self {
        case .getUsersForPage(let page):
            let params: [String: Any] = [
                "page": page,
                "limit": Constants.paginationCount
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .updateUserById(_, let data):
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .getUsersForPage:
            return NETUser.stubList
        case .getUserById, .updateUserById:
            return NETUser.stub
        }
    }
}
