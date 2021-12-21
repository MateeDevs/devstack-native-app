//
//  Created by Petr Chmelar on 28/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation

struct Whisper {
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
    
    static func == (lhs: Whisper, rhs: Whisper) -> Bool {
        lhs.message == rhs.message &&
            lhs.style == rhs.style &&
            lhs.hideAfter == rhs.hideAfter
    }
}
