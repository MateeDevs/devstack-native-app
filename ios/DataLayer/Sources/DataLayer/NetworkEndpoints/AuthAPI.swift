//
//  Created by Petr Chmelar on 19/12/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import Moya

enum AuthAPI {
    case login(_ data: [String: Any])
    case registration(_ data: [String: Any])
}

extension AuthAPI: TargetType {
    var baseURL: URL { URL(string: "\(NetworkingConstants.baseURL)/api")! }
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .registration:
            return "/auth/registration"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .registration:
            return .post
        }
    }
    var headers: [String: String]? {
        nil
    }
    var task: Task {
        switch self {
        case let .login(data):
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case let .registration(data):
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        case .login:
            return NETAuthToken.stub
        case .registration:
            return NETUser.stub
        }
    }
}
