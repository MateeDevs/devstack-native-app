//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RxCocoa
import RxSwift

final class CounterControlViewModel: BaseViewModel, ViewModel {

    typealias Dependencies = HasUpdateProfileCounterUseCase

    let input: Input
    let output: Output

    struct Input {
        let increaseButtonTaps: AnyObserver<Void>
        let decreaseButtonTaps: AnyObserver<Void>
    }

    struct Output {
        let increaseCounter: Driver<Void>
        let decreaseCounter: Driver<Void>
    }

    init(dependencies: Dependencies) {

        // MARK: Setup inputs

        let increaseButtonTaps = PublishSubject<Void>()
        let decreaseButtonTaps = PublishSubject<Void>()

        self.input = Input(
            increaseButtonTaps: increaseButtonTaps.asObserver(),
            decreaseButtonTaps: decreaseButtonTaps.asObserver()
        )

        // MARK: Transformations

        let increaseCounter = increaseButtonTaps.flatMapLatest { _ -> Observable<Void> in
            dependencies.updateProfileCounterUseCase.execute(value: 1).ignoreErrors()
        }.share()

        let decreaseCounter = decreaseButtonTaps.flatMapLatest { _ -> Observable<Void> in
            dependencies.updateProfileCounterUseCase.execute(value: -1).ignoreErrors()
        }.share()

        // MARK: Setup outputs

        self.output = Output(
            increaseCounter: increaseCounter.asDriver(),
            decreaseCounter: decreaseCounter.asDriver()
        )

        super.init()
    }
}
