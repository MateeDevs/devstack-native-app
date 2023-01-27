//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation
import Utilities

public extension Date {
    
    /// Conversion from Date to String using a given formatter.
    func toString(formatter: DateFormatter = Formatter.Date.default) -> String {
        formatter.string(from: self)
    }
}
