//
//  Created by Viktor Kaderabek on 25/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

extension NSObject {

    /// Class name literal
    class var nameOfClass: String {
        guard let className = NSStringFromClass(self).components(separatedBy: ".").last else { return "N/A" }
        return className
    }
}
