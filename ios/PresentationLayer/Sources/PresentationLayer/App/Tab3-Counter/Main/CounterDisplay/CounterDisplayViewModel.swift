//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RxCocoa
import RxSwift

final class CounterDisplayViewModel: BaseViewModel, ViewModel {

    typealias Dependencies = HasGetProfileUseCase

    let input: Input
    let output: Output

    struct Input {
    }

    struct Output {
        let counterValue: Driver<String>
    }

    init(dependencies: Dependencies) {

        // MARK: Setup inputs

        self.input = Input()

        // MARK: Setup outputs
        
        let profile = dependencies.getProfileUseCase.execute().ignoreErrors()

        self.output = Output(
            counterValue: profile.map { "\($0.counter)" }.asDriver()
        )

        super.init()
    }
}
