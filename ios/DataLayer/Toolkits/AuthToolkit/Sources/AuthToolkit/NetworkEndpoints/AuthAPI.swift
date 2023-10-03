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
        case .login: "/auth/login"
        case .registration: "/auth/registration"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .login, .registration: .post
        }
    }
    var headers: [String: String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case let .login(data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case let .registration(data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        }
    }
}
