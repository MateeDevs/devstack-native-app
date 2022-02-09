//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RxCocoa
import RxSwift

final class CounterSharedViewModel: BaseViewModel, ViewModel {
    
    let input: Input
    let output: Output

    struct Input {
        let hideButtonIsOn: AnyObserver<Bool>
    }
    
    struct Output {
        let isCounterHidden: Driver<Bool>
    }
    
    init() {

        // MARK: Setup inputs

        let hideButtonIsOn = PublishSubject<Bool>()

        self.input = Input(
            hideButtonIsOn: hideButtonIsOn.asObserver()
        )

        // MARK: Setup outputs

        self.output = Output(
            isCounterHidden: hideButtonIsOn.asDriver()
        )
        
        super.init()
    }
}
