//
//  Created by Petr Chmelar on 10.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RxCocoa
import RxSwift
import UIKit

final class SettingsViewModel: BaseViewModel, ViewModel {
    
    typealias Dependencies = HasNoUseCase
    
    let input: Input
    let output: Output

    struct Input {
        let smallButtonTaps: AnyObserver<Void>
        let largeButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let topViewHeight: Driver<CGFloat>
    }
    
    init(dependencies: Dependencies) {

        // MARK: Setup inputs

        let smallButtonTaps = PublishSubject<Void>()
        let largeButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            smallButtonTaps: smallButtonTaps.asObserver(),
            largeButtonTaps: largeButtonTaps.asObserver()
        )

        // MARK: Setup outputs
        
        let topViewHeight = Observable<CGFloat>.merge(
            smallButtonTaps.map { 300.0 },
            largeButtonTaps.map { 1200.0 }
        )

        self.output = Output(
            topViewHeight: topViewHeight.asDriver()
        )
        
        super.init()
    }
}
