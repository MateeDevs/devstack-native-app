//
//  Created by Petr Chmelar on 27/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

extension UIImageView {
    
    var rounded: Bool {
        get {
            layer.cornerRadius == frame.height / 2 ? true : false
        }
        set(newValue) {
            layer.cornerRadius = newValue ? frame.height / 2 : 0
            layer.masksToBounds = newValue
            clipsToBounds = newValue
        }
    }
}
