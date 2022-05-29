//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

extension String {
    /// Conversion from String to Date using a given formatter.
    func toDate(formatter: DateFormatter = Formatter.Date.default) -> Date? {
        formatter.date(from: self)
    }
}
