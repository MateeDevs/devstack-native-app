//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import RxTest
import XCTest

class BaseTestCase: XCTestCase {

    var scheduler: TestScheduler! // swiftlint:disable:this implicitly_unwrapped_optional
    var disposeBag: DisposeBag! // swiftlint:disable:this implicitly_unwrapped_optional
    
    /// Override this method in a subclass and setup dependencies
    func setupDependencies() {}

    override func setUp() {
        super.setUp()

        setupDependencies()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
}
