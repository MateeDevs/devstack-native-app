//
//  Created by Petr Chmelar on 10/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation

extension Double {
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
