//
//  Created by Viktor Kaderabek on 12/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })
        
        // Remove the views
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
