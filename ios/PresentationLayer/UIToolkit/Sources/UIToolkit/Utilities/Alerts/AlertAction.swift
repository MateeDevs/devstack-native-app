//
//  Created by Petr Chmelar on 28/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation

public enum AlertAction: Equatable {
    case showWhisper(_ whisper: WhisperData)
    case hideWhisper
    case showAlert(_ alert: AlertData)

    public static func == (lhs: AlertAction, rhs: AlertAction) -> Bool {
        switch (lhs, rhs) {
        case let (.showWhisper(lhsWhisper), .showWhisper(rhsWhisper)): lhsWhisper == rhsWhisper
        case (.hideWhisper, .hideWhisper): true
        case let (.showAlert(lhsAlert), .showAlert(rhsAlert)): lhsAlert == rhsAlert
        default: false
        }
    }
}
