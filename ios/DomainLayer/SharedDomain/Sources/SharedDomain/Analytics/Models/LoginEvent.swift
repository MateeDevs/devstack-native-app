//
//  Created by Petr Chmelar on 26.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public enum LoginEvent {
    case screenAppear
    case loginButtonTap
    case registerButtonTap
}

extension LoginEvent: Trackable {
    public var analyticsEvent: AnalyticsEvent {
        switch self {
        case .screenAppear: .init(name: "login_screen")
        case .loginButtonTap: .init(name: "login_button_tap")
        case .registerButtonTap: .init(name: "register_button_tap")
        }
    }
}
