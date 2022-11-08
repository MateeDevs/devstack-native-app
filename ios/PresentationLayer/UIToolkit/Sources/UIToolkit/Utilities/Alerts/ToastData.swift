//
//  Created by Tomas Brand on 02.11.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import SwiftUI

public struct ToastData {
    let style: ToastStyle
    let title: String
    let hideAfter: TimeInterval
    
    init(_ title: String, style: ToastStyle = .info, hideAfter: TimeInterval = 0.0) {
        self.title = title
        self.style = style
        self.hideAfter = hideAfter
    }
    
    init(error: String, style: ToastStyle = .error, hideAfter: TimeInterval = 2.5) {
        self.title = error
        self.style = style
        self.hideAfter = hideAfter
    }
    
    static func == (lhs: ToastData, rhs: ToastData) -> Bool {
        lhs.title == rhs.title &&
        lhs.style == rhs.style &&
        lhs.hideAfter == rhs.hideAfter
    }
}

public enum ToastStyle {
    case info, success, error
    
    var color: Color {
        switch self {
        case .info: return AppTheme.Colors.whisperBackgroundInfo
        case .success: return AppTheme.Colors.whisperBackgroundSuccess
        case .error: return AppTheme.Colors.whisperBackgroundError
        }
    }
    
    var image: Image {
        switch self {
        case .info: return Image(systemName: "info.circle")
        case .success: return Image(systemName: "checkmark.circle")
        case .error: return Image(systemName: "xmark.circle")
        }
    }
}
