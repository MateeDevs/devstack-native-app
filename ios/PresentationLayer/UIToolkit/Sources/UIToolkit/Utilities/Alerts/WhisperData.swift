//
//  Created by Petr Chmelar on 28/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import SwiftUI

public struct WhisperData {
    let message: String
    let style: WhisperStyle
    let hideAfter: TimeInterval
    
    public init(_ message: String, style: WhisperStyle = .info, hideAfter: TimeInterval = 0.0) {
        self.message = message
        self.style = style
        self.hideAfter = hideAfter
    }
    
    public init(error: String, style: WhisperStyle = .error, hideAfter: TimeInterval = 2.5) {
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

public enum WhisperStyle {
    case info, success, error
    
    var color: Color {
        switch self {
        case .info: AppTheme.Colors.whisperBackgroundInfo
        case .success: AppTheme.Colors.whisperBackgroundSuccess
        case .error: AppTheme.Colors.whisperBackgroundError
        }
    }
}
