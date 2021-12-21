//
//  Created by Krunoslav Zaher on 10/18/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

// Taken from [RxSwift example](https://github.com/ReactiveX/RxSwift/tree/main/RxExample/RxExample/Services)

import Foundation
import RxCocoa
import RxSwift

private struct ActivityToken<E>: ObservableConvertibleType, Disposable {
    private let _source: Observable<E>
    private let _dispose: Cancelable

    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }

    func dispose() {
        _dispose.dispose()
    }

    func asObservable() -> Observable<E> {
        return _source
    }
}

/**
Enables monitoring of sequence computation.
If there is at least one sequence computation in progress, `true` will be sent.
When all activities complete `false` will be sent.
*/
class ActivityIndicator: SharedSequenceConvertibleType {
    typealias Element = Bool
    typealias SharingStrategy = DriverSharingStrategy

    private let _lock = NSRecursiveLock()
    private let _relay = BehaviorRelay(value: 0)
    private let _loading: SharedSequence<SharingStrategy, Bool>

    init() {
        _loading = _relay.asDriver()
            .map { $0 > 0 }
            .distinctUntilChanged()
    }

    fileprivate func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }, observableFactory: { t in
            return t.asObservable()
        })
    }

    private func increment() {
        _lock.lock()
        _relay.accept(_relay.value + 1)
        _lock.unlock()
    }

    private func decrement() {
        _lock.lock()
        _relay.accept(_relay.value - 1)
        _lock.unlock()
    }

    func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        return _loading
    }
}

extension ObservableConvertibleType {
    func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<Element> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}

extension ActivityIndicator {
    /// Transformation that maps true from ActivityIndicator to AlertAction.showWhisper with a given message
    func toWhisper(_ message: String) -> Observable<AlertAction> {
        return asObservable().filter { $0 }.map { _ in .showWhisper(Whisper(message)) }
    }
}
