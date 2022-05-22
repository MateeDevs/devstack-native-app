//
//  Created by Petr Chmelar on 28/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import UIKit

struct WhisperData {
    let message: String
    let style: WhisperStyle
    let hideAfter: TimeInterval
    
    init(_ message: String, style: WhisperStyle = .info, hideAfter: TimeInterval = 0.0) {
        self.message = message
        self.style = style
        self.hideAfter = hideAfter
    }
    
    init(error: String, style: WhisperStyle = .error, hideAfter: TimeInterval = 2.5) {
        self.message = error
        self.style = style
        self.hideAfter = hideAfter
    }
    
    static func == (lhs: WhisperData, rhs: WhisperData) -> Bool {
        lhs.message == rhs.message &&
        lhs.style == rhs.style &&
        lhs.hideAfter == rhs.hideAfter
    }
}

enum WhisperStyle {
    case info, success, error
    
    var color: UIColor {
        switch self {
        case .info: return AppTheme.Colors.alertBackgroundInfo
        case .success: return AppTheme.Colors.alertBackgroundSuccess
        case .error: return AppTheme.Colors.alertBackgroundError
        }
    }
}
