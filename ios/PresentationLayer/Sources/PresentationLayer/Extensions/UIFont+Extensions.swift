//
//  Created by Petr Chmelar on 11/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

extension UIFont {
    
    ///
    /// Helper for easy access to custom font.
    ///
    /// - parameter ofSize: Font size to be used.
    /// - returns: Custom font of a defined size.
    ///
    static func customFont(ofSize size: CGFloat) -> UIFont? {
        UIFont(name: "CustomFont", size: size)
    }
    
    ///
    /// Helper for font size scaling.
    ///
    /// - parameter baseSize: Font size defined for 320x568 screen size.
    /// - returns: Font size scaled for real screen size.
    ///
    static func scalableFontSize(_ baseSize: CGFloat) -> CGFloat {
        ((UIScreen.main.bounds.size.height * baseSize / 568.0) * (320.0 / UIScreen.main.bounds.size.width))
    }
    
}
