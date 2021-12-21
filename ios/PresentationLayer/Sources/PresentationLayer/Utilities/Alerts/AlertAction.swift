//
//  Created by Petr Chmelar on 28/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation

enum AlertAction: Equatable {
    case showWhisper(_ whisper: Whisper)
    case hideWhisper
    case showAlert(_ alert: Alert)

    static func == (lhs: AlertAction, rhs: AlertAction) -> Bool {
        switch (lhs, rhs) {
        case let (.showWhisper(lhsWhisper), .showWhisper(rhsWhisper)):
            return lhsWhisper == rhsWhisper
        case (.hideWhisper, .hideWhisper):
            return true
        case let (.showAlert(lhsAlert), .showAlert(rhsAlert)):
            return lhsAlert == rhsAlert
        default:
            return false
        }
    }
}
