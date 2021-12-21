//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

extension Date {
    
    /// Conversion from Date to String using a given formatter.
    func toString(formatter: DateFormatter = Formatter.dateDefault) -> String {
        formatter.string(from: self)
    }
    
    /// Elapsed time between date and now (nil for future dates).
    /// - Converted into localized String "Before xyz days/hours/minutes"
    var elapsedTimeString: String? {
        let elapsedTime = Date().timeIntervalSince(self)
        if elapsedTime < 0 {
            return nil
        } else if elapsedTime < 60 {
            return L10n.time_events_now
        } else if elapsedTime < 60 * 60 {
            return Plurals.minutes_before.stringForCount(Int(ceil(elapsedTime / 60)))
        } else if elapsedTime < 60 * 60 * 24 {
            return Plurals.hours_before.stringForCount(Int(ceil(elapsedTime / (60 * 60))))
        } else {
            return Plurals.days_before.stringForCount(Int(ceil(elapsedTime / (60 * 60 * 24))))
        }
    }
}
