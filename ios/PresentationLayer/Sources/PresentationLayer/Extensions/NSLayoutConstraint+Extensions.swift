//
//  Created by Petr Chmelar on 01/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    ///
    /// Change constraint's multiplier
    ///
    /// - parameter multiplier: CGFloat value of multiplier
    /// - returns: NSLayoutConstraint with a given multiplier
    ///
    func cloneWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint? {
        
        guard let firstItem = firstItem, let secondItem = secondItem else { return nil }
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.identifier = identifier
        
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
}
