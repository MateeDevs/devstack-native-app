//
//  Created by Viktor Kaderabek on 10/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import Foundation

extension Int {
    
    /// Conversion from Int to String using a given formatter.
    func toString(formatter: NumberFormatter = Formatter.Number.default) -> String {
        formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
