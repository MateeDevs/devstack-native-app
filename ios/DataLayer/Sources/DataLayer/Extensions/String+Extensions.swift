//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

extension String {
    var utf8Encoded: Data {
        data(using: .utf8)!
    }
}
