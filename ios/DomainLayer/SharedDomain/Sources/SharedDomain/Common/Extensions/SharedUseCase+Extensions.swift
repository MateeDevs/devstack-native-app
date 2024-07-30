// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable multiline_arguments

import KMPShared
import Foundation

private class JobWrapper {
    var job: Kotlinx_coroutines_coreJob?
    
    func setJob(_ job: Kotlinx_coroutines_coreJob?) {
        self.job = job
    }
}

public extension UseCaseFlowNoParams {
    func execute<Out>() -> AsyncStream<Out> {
        let _: JobWrapper = JobWrapper()
        return AsyncStream<Out> { continuation in
            let coroutineJob = SwiftCoroutinesKt.subscribe(self) { data in
                let value: Out = data as! Out
                continuation.yield(value)
            } onComplete: {
                continuation.finish()
            } onThrow: { _ in
                continuation.finish()
            }
            continuation.onTermination = { _ in
                coroutineJob.cancel(cause: nil)
            }
        }
    }
}

// returns unwrapped result, for try await should be wrapped in do-catch block
public extension UseCaseFlowResult {
    func execute<In: Any, Out>(params: In) -> AsyncThrowingStream<Out, Error> {
        let _: JobWrapper = JobWrapper()
        return AsyncThrowingStream<Out, Error> { continuation in
            let coroutineJob = SwiftCoroutinesKt.subscribe(self, params: params) { result in
                switch result {
                case let resultSuccess as ResultSuccess<AnyObject>:
                    // if new possible type is needed, it can be added to this switch
                    switch resultSuccess.data {
                    case let resultSuccess as NSArray:
                        let arrayValue = (resultSuccess as? [Any]) as! Out
                        continuation.yield(arrayValue)
                    case let resultSuccess as KotlinBoolean:
                        let boolValue = resultSuccess.boolValue as! Out
                        continuation.yield(boolValue)
                    default:
                        continuation.yield(resultSuccess as! Out)
                    }
                case let resultError as ResultError<AnyObject>:
                    let resultError = resultError.error
                    continuation.finish(
                        throwing: KmmLocalizedError(
                            errorResult: resultError,
                            localizedMessage: resultError.localizedMessage(nil)
                        )
                    )
                default:
                    let resultError = CommonError.Unknown()
                    continuation.finish(
                        throwing: KmmLocalizedError(
                            errorResult: resultError,
                            localizedMessage: resultError.localizedMessage(nil)
                        )
                    )
                }
            } onComplete: {
                continuation.finish()
            } onThrow_: { error in
                continuation.finish(throwing: error.asError())
            }
            continuation.onTermination = { _ in
                coroutineJob.cancel(cause: nil)
            }
        }
    }
}

public extension UseCaseResult {
    func execute<In: Any, Out>(params: In) async throws -> Out {
        let jobWrapper: JobWrapper = JobWrapper()
        return try await withTaskCancellationHandler(
            operation: {
                try await withCheckedThrowingContinuation { continuation in
                    
                    let coroutineJob = SwiftCoroutinesKt.subscribe(
                        self,
                        params: params,
                        onSuccess: { result in
                            guard result is ResultSuccess else {
                                let errorResult = (result as! ResultError).error
                                continuation.resume(throwing: KmmLocalizedError(errorResult: errorResult, localizedMessage: errorResult.localizedMessage(nil)))
                                return
                            }
                            let value: Out = (result as! ResultSuccess).data as! Out
                            continuation.resume(returning: value)
                            return
                        },
                        onThrow: { kotlinThrowable in
                            continuation.resume(throwing: KmmLocalizedError(errorResult: nil, localizedMessage: kotlinThrowable.message ?? kotlinThrowable.description()))
                        })
                    jobWrapper.setJob(coroutineJob)
                }
            },
            onCancel: {[jobWrapper] in
                jobWrapper.job?.cancel(cause: nil)
            }
        )
    }
    
    func execute<In: Any>(params: In) async throws {
        let jobWrapper: JobWrapper = JobWrapper()
        return try await withTaskCancellationHandler(
            operation: {
                try await withCheckedThrowingContinuation { continuation in
                    
                    let coroutineJob = SwiftCoroutinesKt.subscribe(
                        self,
                        params: params,
                        onSuccess: { result in
                            guard result is ResultSuccess else {
                                let errorResult = (result as! ResultError).error
                                continuation.resume(throwing: KmmLocalizedError(errorResult: errorResult, localizedMessage: errorResult.localizedMessage(nil)))
                                return
                            }
                            continuation.resume()
                            return
                        },
                        onThrow: { kotlinThrowable in
                            continuation.resume(throwing: KmmLocalizedError(errorResult: nil, localizedMessage: kotlinThrowable.message ?? kotlinThrowable.description()))
                        })
                    jobWrapper.setJob(coroutineJob)
                }
            },
            onCancel: {[jobWrapper] in
                jobWrapper.job?.cancel(cause: nil)
            }
        )
    }
}

public extension UseCaseResultNoParams {
    func execute<Out>() async throws -> Out {
        let jobWrapper: JobWrapper = JobWrapper()
        return try await withTaskCancellationHandler(
            operation: {
                try await withCheckedThrowingContinuation { continuation in
                    
                    let coroutineJob = SwiftCoroutinesKt.subscribe(
                        self,
                        onSuccess: { result in
                            guard result is ResultSuccess else {
                                let errorResult = (result as! ResultError).error
                                continuation.resume(throwing: KmmLocalizedError(errorResult: errorResult, localizedMessage: errorResult.localizedMessage(nil)))
                                return
                            }
                            let value: Out = (result as! ResultSuccess).data as! Out
                            continuation.resume(returning: value)
                            return
                        },
                        onThrow: { kotlinThrowable in
                            continuation.resume(throwing: KmmLocalizedError(errorResult: nil, localizedMessage: kotlinThrowable.message ?? kotlinThrowable.description()))
                        })
                    jobWrapper.setJob(coroutineJob)
                }
            },
            onCancel: {[jobWrapper] in
                jobWrapper.job?.cancel(cause: nil)
            }
        )
    }
    
    // Void returining UC
    func execute() async throws {
        let jobWrapper: JobWrapper = JobWrapper()
        return try await withTaskCancellationHandler(
            operation: {
                try await withCheckedThrowingContinuation { continuation in
                    
                    let coroutineJob = SwiftCoroutinesKt.subscribe(
                        self,
                        onSuccess: { result in
                            guard result is ResultSuccess else {
                                let errorResult = (result as! ResultError).error
                                continuation.resume(throwing: KmmLocalizedError(errorResult: errorResult, localizedMessage: errorResult.localizedMessage(nil)))
                                return
                            }
                            continuation.resume()
                            return
                        },
                        onThrow: { kotlinThrowable in
                            continuation.resume(throwing: KmmLocalizedError(errorResult: nil, localizedMessage: kotlinThrowable.message ?? kotlinThrowable.description()))
                        })
                    jobWrapper.setJob(coroutineJob)
                }
            },
            onCancel: {[jobWrapper] in
                jobWrapper.job?.cancel(cause: nil)
            }
        )
    }
}
