//
//  Created by Petr Chmelar on 05/03/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import RxCocoa
import RxSwift

final class RegistrationViewModel: BaseViewModel, ViewModel {
    
    typealias Dependencies = HasRegistrationUseCase
    
    let input: Input
    let output: Output
    
    struct Input {
        let email: BehaviorRelay<String>
        let password: BehaviorRelay<String>
        let registerButtonTaps: AnyObserver<Void>
        let loginButtonTaps: AnyObserver<Void>
    }
    
    struct Output {
        let flow: Driver<Flow.Registration>
        let registerButtonEnabled: Driver<Bool>
        let alertAction: Driver<AlertAction>
    }
    
    init(dependencies: Dependencies) {
        
        // MARK: Setup inputs
        
        let email = BehaviorRelay<String>(value: "")
        let password = BehaviorRelay<String>(value: "")
        let registerButtonTaps = PublishSubject<Void>()
        let loginButtonTaps = PublishSubject<Void>()
        
        self.input = Input(
            email: email,
            password: password,
            registerButtonTaps: registerButtonTaps.asObserver(),
            loginButtonTaps: loginButtonTaps.asObserver()
        )

        // MARK: Transformations
        
        let activity = ActivityIndicator()
        
        let inputs = Observable.combineLatest(email, password) { (email: $0, password: $1) }
        
        let registration = registerButtonTaps.withLatestFrom(inputs).flatMapLatest { inputs -> Observable<Event<Void>> in
            if inputs.email.isEmpty || inputs.password.isEmpty {
                return .just(.error(ValidationError(L10n.invalid_credentials)))
            } else if !inputs.email.isValidEmail {
                return .just(.error(ValidationError(L10n.invalid_email)))
            } else {
                let data = RegistrationData(email: inputs.email, password: inputs.password, firstName: "Anonymous", lastName: "")
                return dependencies.registrationUseCase.execute(data).trackActivity(activity).materialize()
            }
        }.share()
        
        let flow = Observable<Flow.Registration>.merge(
            registration.compactMap { $0.element }.mapToVoid().map { .popRegistration },
            loginButtonTaps.map { .popRegistration }
        )
        
        let messages = ErrorMessages([.httpConflict: L10n.register_view_email_already_exists], defaultMessage: L10n.signing_up_failed)
        
        let alertAction = Observable<AlertAction>.merge(
            activity.toWhisper(L10n.signing_up),
            registration.compactMap { $0.element }.map { _ in .hideWhisper },
            registration.compactMap { $0.error }.map {
                .showWhisper(Whisper(error: $0.toString(messages)))
            }
        )

        // MARK: Setup outputs
        
        self.output = Output(
            flow: flow.asDriver(),
            registerButtonEnabled: activity.map { !$0 },
            alertAction: alertAction.asDriver()
        )
        
        super.init()
    }
}
