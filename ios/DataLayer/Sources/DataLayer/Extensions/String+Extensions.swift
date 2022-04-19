//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Foundation

extension String {
    var utf8Encoded: Data {
        data(using: .utf8)!
    }
    
    /// Conversion from String to Date using a given formatter.
    func toDate(formatter: DateFormatter = Formatter.Date.default) -> Date? {
        formatter.date(from: self)
    }
}
