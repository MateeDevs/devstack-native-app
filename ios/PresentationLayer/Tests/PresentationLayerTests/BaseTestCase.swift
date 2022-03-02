//
//  Created by Petr Chmelar on 24/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import RxTest
import XCTest

@MainActor
class BaseTestCase: XCTestCase {

    var scheduler: TestScheduler! // swiftlint:disable:this implicitly_unwrapped_optional
    var disposeBag: DisposeBag! // swiftlint:disable:this implicitly_unwrapped_optional
    
    /// Override this method in a subclass and register dependencies
    func setupDependencies() {}

    @MainActor
    override func setUp() {
        super.setUp()

        setupDependencies()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    func testableOutput<T>(from driver: Driver<T>) -> TestableObserver<T> {
        let output = scheduler.createObserver(T.self)
        driver.drive(output).disposed(by: disposeBag)
        return output
    }
}
