//
//  Created by Petr Chmelar on 28.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public enum UserEvent {
    case userDetail(id: String)
}

extension UserEvent: Trackable {
    public var analyticsEvent: AnalyticsEvent {
        switch self {
        case .userDetail(let id): return .init(name: "user_detail", params: ["id": id])
        }
    }
}
