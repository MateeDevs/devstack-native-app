//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import XCTest

class BaseTestCase: XCTestCase {

    override func setUp() {
        super.setUp()

        setupDependencies()
    }
    
    /// Override this method in a subclass and setup dependencies
    func setupDependencies() {}
}
