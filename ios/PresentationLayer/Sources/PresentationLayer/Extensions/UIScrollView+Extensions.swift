//
//  Created by Petr Chmelar on 11/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func isNearBottomEdge(edgeOffset: CGFloat = 100.0) -> Bool {
        contentOffset.y + frame.size.height + edgeOffset > contentSize.height
    }
    
    func isOverTopEdge(edgeOffset: CGFloat = -10.0) -> Bool {
        contentOffset.y < edgeOffset
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = AppTheme.Colors.activityIndicator
        self.refreshControl = refreshControl
    }
}
