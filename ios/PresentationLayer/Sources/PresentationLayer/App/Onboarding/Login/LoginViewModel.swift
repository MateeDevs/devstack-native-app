//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import RxCocoa
import RxSwift

final class LoginViewModel: BaseViewModel, ViewModel {
    
    typealias Dependencies =
        HasLoginUseCase &
        HasTrackAnalyticsEventUseCase
    
    let input: Input
    let output: Output
    
    struct Input {
        let email: BehaviorRelay<String>
        let password: BehaviorRelay<String>
        let loginButtonTaps: AnyObserver<Void>
        let registerButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let flow: Driver<Flow.Login>
        let loginButtonEnabled: Driver<Bool>
        let alertAction: Driver<AlertAction>
    }
    
    init(dependencies: Dependencies) {
        
        // MARK: Setup inputs
        
        let email = BehaviorRelay<String>(value: "")
        let password = BehaviorRelay<String>(value: "")
        let loginButtonTaps = PublishSubject<Void>()
        let registerButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            email: email,
            password: password,
            loginButtonTaps: loginButtonTaps.asObserver(),
            registerButtonTaps: registerButtonTaps.asObserver()
        )

        // MARK: Transformations
        
        let activity = ActivityIndicator()
        
        let inputs = Observable.combineLatest(email, password) { (email: $0, password: $1) }
        
        let login = loginButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Observable<Event<Void>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
                return .just(.error(ValidationError(L10n.invalid_credentials)))
            } else {
                dependencies.trackAnalyticsEventUseCase.execute(LoginEvent.loginButtonTap.analyticsEvent)
                let data = LoginData(email: inputs.email, password: inputs.password)
                return dependencies.loginUseCase.execute(data).trackActivity(activity).materialize()
            }
        }.share()
        
        let flow = Observable<Flow.Login>.merge(
            login.compactMap { $0.element }.map { .dismiss },
            registerButtonTaps.map { .showRegistration }.do { _ in
                dependencies.trackAnalyticsEventUseCase.execute(LoginEvent.registerButtonTap.analyticsEvent)
            }
        )
        
        let messages = ErrorMessages([.httpUnathorized: L10n.invalid_credentials], defaultMessage: L10n.signing_failed)
        
        let alertAction = Observable<AlertAction>.merge(
            activity.toWhisper(L10n.signing_in),
            login.compactMap { $0.element }.map { .hideWhisper },
            login.compactMap { $0.error }.map {
                .showWhisper(Whisper(error: $0.toString(messages)))
            }
        )

        // MARK: Setup outputs
        
        self.output = Output(
            flow: flow.asDriver(),
            loginButtonEnabled: activity.map { !$0 },
            alertAction: alertAction.asDriver()
        )
        
        super.init(
            trackScreenAppear: { dependencies.trackAnalyticsEventUseCase.execute(LoginEvent.screenAppear.analyticsEvent) }
        )
    }
}
