//
//  Created by Petr Chmelar on 19/12/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import NetworkProvider
import Utilities

enum AuthAPI {
    case login(_ data: [String: Any])
    case registration(_ data: [String: Any])
}

extension AuthAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: "\(NetworkingConstants.baseURL)/api")! }
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .registration:
            return "/auth/registration"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .login, .registration:
            return .post
        }
    }
    var headers: [String: String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case let .login(data):
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case let .registration(data):
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        }
    }
}
