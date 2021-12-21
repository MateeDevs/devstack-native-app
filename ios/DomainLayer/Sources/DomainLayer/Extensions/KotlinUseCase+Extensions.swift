//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared
import Foundation
import RxSwift

// swiftlint:disable file_length

public extension RefreshBooksUseCase {
    func execute() -> Observable<Event<Void>> {
        return createObservable(self)
    }
}

public extension GetBooksUseCase {
    func execute() -> Observable<[Book]> {
        return createObservable(self).map { (nsArray: NSArray) -> [Book] in
            nsArray as! [Book] // swiftlint:disable:this force_cast
        }
    }
}

// All usecases runs on Dispatcher.Default and it means that every async operation is executed by system backround thread - in case of ios it should be an IO thread

// Create observable from suspendable usecase with params
// Invoke usecase and complete
func createObservable<Params, KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseResult,
    _ params: Params,
    _ transform: @escaping (KotlinDomain) -> SwiftDomain
) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = SwiftCoroutinesKt.subscribe(
            usecase,
            params: params,
            onSuccess: { result in
                guard let success = result as? ResultSuccess else {
                    guard let errorResult = result as? ResultError else { return }
                    observer.on(.error(errorResult.error.swiftError)); return
                }
                observer.on(.next(transform(success.data as! KotlinDomain))) // swiftlint:disable:this force_cast
                observer.onCompleted()
            },
            onThrow_: { kotlinThrowable in
                observer.on(.error(KotlinThrowableError(kotlinThrowable)))
            })
        return Disposables.create { job.cancel(cause: nil) }
    }
}

// Create observable from usecase with params that retuns flow
// Invoke usecase and collect all values from flow. When flow ends than observable stream ends
func createObservable<Params, KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseFlowResult,
    _ params: Params,
    _ transform:@escaping (KotlinDomain) -> SwiftDomain
) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = SwiftCoroutinesKt.subscribe(
            usecase,
            params: params,
            onEach: { result in
                guard let success = result as? ResultSuccess else {
                    guard let errorResult = result as? ResultError else { return }
                    observer.on(.error(errorResult.error.swiftError)); return
                }
                observer.on(.next(transform(success.data as! KotlinDomain))) // swiftlint:disable:this force_cast
            },
            onComplete: {
                observer.on(.completed)
            },
            onThrow_: { kotlinThrowable in
                observer.on(.error(KotlinThrowableError(kotlinThrowable)))
            })
        return Disposables.create { job.cancel(cause: nil) }
    }
}

// Create observable from suspendable usecase without
// Invoke usecase and complete
func createObservable<KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseResultNoParams,
    _ transform:@escaping (KotlinDomain) -> SwiftDomain
) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = SwiftCoroutinesKt.subscribe(
            usecase,
            onSuccess: { result in
                guard let success = result as? ResultSuccess else {
                    guard let errorResult = result as? ResultError else { return }
                    observer.on(.error(errorResult.error.swiftError)); return
                }
                observer.on(.next(transform(success.data as! KotlinDomain))) // swiftlint:disable:this force_cast
                observer.onCompleted()
            },
            onThrow_: { kotlinThrowable in
                observer.on(.error(KotlinThrowableError(kotlinThrowable)))
            })
        return Disposables.create { job.cancel(cause: nil) }
    }
}

// Create observable from usecase without params that retuns flow
// Invoke usecase and collect all values from flow. When flow ends than observable stream ends
func createObservable<KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseFlowResultNoParams,
    _ transform:@escaping (KotlinDomain) -> SwiftDomain
) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = SwiftCoroutinesKt.subscribe(
            usecase,
            onEach: { result in
                guard let success = result as? ResultSuccess else {
                    guard let errorResult = result as? ResultError else { return }
                    observer.on(.error(errorResult.error.swiftError)); return
                }
                observer.on(.next(transform(success.data as! KotlinDomain))) // swiftlint:disable:this force_cast
            },
            onComplete: {
                observer.on(.completed)
            },
            onThrow_: { kotlinThrowable in
                observer.on(.error(KotlinThrowableError(kotlinThrowable)))
            })
        return Disposables.create { job.cancel(cause: nil) }
    }
}

// Create observable from usecase that returns unit -> void
// Invoke usecase and complete
func createObservable<Params>(
    _ usecase: UseCaseResult,
    _ params: Params
) -> Observable<Event<Void>> {
    
    return Observable<Void>.create { observer in
        let job: Kotlinx_coroutines_coreJob = SwiftCoroutinesKt.subscribe(
            usecase,
            params: params,
            onSuccess: { result in
                guard result is ResultSuccess else {
                    guard let errorResult = result as? ResultError else { return }
                    observer.on(.error(errorResult.error.swiftError)); return
                }
                observer.on(.next(()))
                observer.onCompleted()
            },
            onThrow_: { kotlinThrowable in
                observer.on(.error(KotlinThrowableError(kotlinThrowable)))
            })
        return Disposables.create { job.cancel(cause: nil) }
    }.mapToVoid().materialize()
}

// Create observable from usecase that returns unit -> void
// Invoke usecase and complete
func createObservable(
    _ usecase: UseCaseResultNoParams
) -> Observable<Event<Void>> {
    
    return Observable<Void>.create { observer in
        let job: Kotlinx_coroutines_coreJob = SwiftCoroutinesKt.subscribe(
            usecase,
            onSuccess: { result in
                guard result is ResultSuccess else {
                    guard let errorResult = result as? ResultError else { return }
                    observer.on(.error(errorResult.error.swiftError)); return
                }
                observer.on(.next(()))
                observer.onCompleted()
            },
            onThrow_: { kotlinThrowable in
                observer.on(.error(KotlinThrowableError(kotlinThrowable)))
            }
        )
        return Disposables.create { job.cancel(cause: nil) }
    }.mapToVoid().materialize()
}

// Create observable from usecase without params that retuns flow
// Invoke usecase and collect all values from flow. When flow ends than observable stream ends
func createObservable<KotlinDomain, SwiftDomain>(
    _ usecase: UseCaseFlowNoParams,
    _ transform:@escaping (KotlinDomain) -> SwiftDomain
) -> Observable<SwiftDomain> {
    
    return Observable<SwiftDomain>.create { observer in
        let job: Kotlinx_coroutines_coreJob = SwiftCoroutinesKt.subscribe(
            usecase,
            onEach: { item in
                observer.on(.next(transform(item as! KotlinDomain))) // swiftlint:disable:this force_cast
            },
            onComplete: {
                observer.on(.completed)
            },
            onThrow: { kotlinThrowable in
                observer.on(.error(KotlinThrowableError(kotlinThrowable)))
            }
        )
        return Disposables.create { job.cancel(cause: nil) }
    }
}

func createObservable<KotlinDomain>(
    _ usecase: UseCaseFlowNoParams
) -> Observable<KotlinDomain> {
    
    return Observable.create { observer in
        let job: Kotlinx_coroutines_coreJob = SwiftCoroutinesKt.subscribe(
            usecase,
            onEach: { item in
                observer.on(.next(item as! KotlinDomain)) // swiftlint:disable:this force_cast
            },
            onComplete: {
                observer.on(.completed)
            },
            onThrow: { kotlinThrowable in
                observer.on(.error(KotlinThrowableError(kotlinThrowable)))
            }
        )
        return Disposables.create { job.cancel(cause: nil) }
    }
}

extension DevstackKmpShared.ErrorResult {
    var swiftError: LocalizedError {
        self.toSwiftError()
    }
    
    private func toSwiftError() -> LocalizedError {
        switch self {
        case is BackendError.NotAuthorized:
            return RepositoryError(statusCode: StatusCode.unknown, message: self.message ?? "Unknown")
        default:
            return RepositoryError(statusCode: StatusCode.unknown, message: self.message ?? "Unknown")
        }
    }
}

class UnknownKotlinError: LocalizedError {}

class KotlinThrowableError: LocalizedError {
    let throwable: KotlinThrowable
    
    init( _ throwable: KotlinThrowable) { self.throwable = throwable }
    
    var errorDescription: String? { throwable.message }
}
