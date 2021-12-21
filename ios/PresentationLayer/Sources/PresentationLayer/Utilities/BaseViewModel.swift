//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer

class BaseViewModel {
    
    let trackScreenAppear: () -> Void

    init(trackScreenAppear: @escaping () -> Void = {}) {
        self.trackScreenAppear = trackScreenAppear
        Logger.info("%@ initialized", "\(type(of: self))", category: .lifecycle)
    }
    
    deinit {
        Logger.info("%@ deinitialized", "\(type(of: self))", category: .lifecycle)
    }
}
