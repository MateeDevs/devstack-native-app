// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable multiline_arguments

import DevstackKmpShared
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

public extension UseCaseFlowResult {
    func execute<In: Any, Out>(params: In) -> AsyncStream<Out> {
        let _: JobWrapper = JobWrapper()
        return AsyncStream<Out> { continuation in
            let coroutineJob = SwiftCoroutinesKt.subscribe(self, params: params) { result in
                continuation.yield(result as! Out)
            } onComplete: {
                continuation.finish()
            } onThrow_: { _ in
                continuation.finish()
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
                                let error = (result as! ResultError).error.asError
                                continuation.resume(throwing: error)
                                return
                            }
                            let value: Out = (result as! ResultSuccess).data as! Out
                            continuation.resume(returning: value)
                            return
                        },
                        onThrow: { kotlinThrowable in
                            continuation.resume(throwing: kotlinThrowable.asError())
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
                                let error = (result as! ResultError).error.asError
                                continuation.resume(throwing: error)
                                return
                            }
                            continuation.resume()
                            return
                        },
                        onThrow: { kotlinThrowable in
                            continuation.resume(throwing: kotlinThrowable.asError())
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
                                let error = (result as! ResultError).error.asError
                                continuation.resume(throwing: error)
                                return
                            }
                            let value: Out = (result as! ResultSuccess).data as! Out
                            continuation.resume(returning: value)
                            return
                        },
                        onThrow: { kotlinThrowable in
                            continuation.resume(throwing: kotlinThrowable.asError())
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
                                let error = (result as! ResultError).error.asError
                                continuation.resume(throwing: error)
                                return
                            }
                            continuation.resume()
                            return
                        },
                        onThrow: { kotlinThrowable in
                            continuation.resume(throwing: kotlinThrowable.asError())
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
