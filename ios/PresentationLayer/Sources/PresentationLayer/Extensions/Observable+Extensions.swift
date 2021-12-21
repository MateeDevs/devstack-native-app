//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RxCocoa
import RxSwift

extension ObservableType {
    /// Helper that just completes on error
    func asDriver() -> Driver<Element> {
        asDriver { _ in .empty() }
    }
}
