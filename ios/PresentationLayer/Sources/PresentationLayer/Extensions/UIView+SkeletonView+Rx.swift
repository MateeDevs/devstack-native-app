//
//  Created by Petr Chmelar on 21/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import SkeletonView
import UIKit

extension Reactive where Base: UIView {
    /// Bindable sink for `showSkeleton()`, `hideSkeleton()` methods
    var skeletonView: Binder<Bool> {
        Binder(self.base) { base, isLoading in
            if isLoading {
                base.showAnimatedGradientSkeleton(animation: GradientDirection.topLeftBottomRight.slidingAnimation())
            } else {
                #warning("FIXME: Delay is just for a show case purpose")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    self.base.hideSkeleton()
                }
            }
        }
    }
}
