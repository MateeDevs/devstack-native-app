//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import CoreGraphics
import DevstackKmpShared
import DomainLayer
import Resolver
import RxCocoa
import RxSwift

// swiftlint:disable line_length file_length

class JobWrapper {
    var job: Kotlinx_coroutines_coreJob?
    
    func setJob(_ job: Kotlinx_coroutines_coreJob?) {
        self.job = job
    }
    
}

extension UseCaseResult {
    
//    func executes<In: Any,Out:Void>(params: In) async throws -> Out {
    func executes<In: Any>(params: In) async throws {
        let jobWrapper: JobWrapper = JobWrapper()
        return try await withTaskCancellationHandler(
            operation: {
                try await withCheckedThrowingContinuation { continuation in
                
                    let coroutineJob = SwiftCoroutinesKt.subscribe(
                        self,
                        params: params,
                        onSuccess: { result in
                            guard result is ResultSuccess else {
//                                guard let errorResult = result as! ResultError else { return }
                                continuation.resume(throwing: (result as! ResultError).error.throwable!.asError()) // swiftlint:disable:this force_cast
                                return
                            }
                            continuation.resume()
                            
                        },
                        onThrow_: { kotlinThrowable in
                            continuation.resume(throwing: kotlinThrowable.asError())
                        })
                    jobWrapper.setJob(coroutineJob)
                    print("Refresh: \(coroutineJob)")
                }
            },
            onCancel: {[jobWrapper] in
                guard let job = jobWrapper.job else { return }
                print("Refresh: onCancel\(job)")
                job.cancel(cause: nil)
                print("Refresh: coroutine has been cancelled")
            }
        )
    }

}

extension BaseViewModel {
    
    func execute(params: Any, uc: UseCaseResult) async throws -> Result<AnyObject> {
        let jobWrapper: JobWrapper = JobWrapper()
        return try await withTaskCancellationHandler(
            operation: {
                try await withCheckedThrowingContinuation { continuation in
                
                    let coroutineJob = SwiftCoroutinesKt.subscribe(
                        uc,
                        params: params,
                        onSuccess: { result in
                            continuation.resume(returning: result )
                            
                        },
                        onThrow_: { kotlinThrowable in
                            continuation.resume(throwing: kotlinThrowable.asError())
                        })
                    jobWrapper.setJob(coroutineJob)
                    print("Refresh: \(coroutineJob)")
                }
            },
            onCancel: {[jobWrapper] in
                guard let job = jobWrapper.job else { return }
                print("Refresh: onCancel\(job)")
                job.cancel(cause: nil)
                print("Refresh: coroutine has been cancelled")
            }
        )
        
//        let job = SwiftCoroutinesKt.subscribe(
//            uc,
//            params: params,
//            onSuccess: onSuccess,
//            onThrow_: onThrow)
    }
    
}

final class BooksViewModel: BaseViewModel, ViewModelUIKit {
    
    let input: Input
    let output: Output
    
    struct Input {
        let page: AnyObserver<Int>
    }
    
    struct Output {
        let books: Driver<[Book]>
        let loadedCount: Driver<Int>
        let isRefreshing: Driver<Bool>
    }
    
    convenience init() {
        self.init(
            getBooksUseCase: Resolver.resolve(),
            refreshBooksUseCase: Resolver.resolve()
        )
    }
    
    let refreshBooks: RefreshBooksUseCase
    
    init(
        getBooksUseCase: GetBooksUseCase,
        refreshBooksUseCase: RefreshBooksUseCase
    ) {
        
        // MARK: Setup inputs
        self.refreshBooks = refreshBooksUseCase
        
        let page = PublishSubject<Int>()
        
        self.input = Input(
            page: page.asObserver()
        )
        
        // MARK: Transformations
//        Task{
//            for n in 0...1000 {
//                print("\r⚡️: \(Thread.current)\r" + "🏭: \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r")
//                try await Task.sleep(nanoseconds: 1_000_000_000)
//                do{
//                    print("Refresh start:\(n)")
//                    try await refreshBooksUseCase.execute(params: 10_000).asSingle().value
//                    // let result = try await refreshBooksUseCase.invoke(params: 1000)
//                    print("Refresh done:\(n)")
//                    sleep(1)
//                }catch{
//                    print("Refresh failed:\(n)")
//                }
//                // try await UC2(n: n, refreshBooksUseCase: refreshBooksUseCase)
//            }
//        }
        
        let books = getBooksUseCase.execute().ignoreErrors().share(replay: 1)
        
        let activity = ActivityIndicator()
        
        let refreshBooks = page.flatMap { _ -> Observable<Int> in
            refreshBooksUseCase.execute(params: 100_000).map({ _ in 100 }).trackActivity(activity).ignoreErrors()
        }.share()
        
        let isRefreshing = Observable<Bool>.merge(
            activity.asObservable(),
            refreshBooks.map { _ in false }
        )
        
        // MARK: Setup outputs
        
        self.output = Output(
            books: books.asDriver(),
            loadedCount: refreshBooks.asDriver(),
            isRefreshing: isRefreshing.asDriver()
        )
        
        super.init()
        
//        for n in 0...1000 {
//            execute(params: 10_000_000,uc: refreshBooksUseCase,
//                    onSuccess: { result in
//                guard result is ResultSuccess else {
//                    guard let errorResult = result as? ResultError else { return }
//                    print("Refresh failed:\(n)")
//                    return
//                }
//                print("Refresh done:\(n)")
//
//            },
//                    onThrow: { kotinThrowable in
//
//                print("Refresh failed:\(n)")
//            })
//        }
        
    }
    
    var task: Task<Void, Never>?
    
    func start() {
        task = Task<Void, Never> {
            for n in 0...1000 {
                if Task.isCancelled { break }
                do {
                    print("Refresh start:\(n)")
                    
                    try await refreshBooks.executes(params: 1_000_000)
                    print("Refresh done:\(n)")
                    
                } catch {
                    print("Refresh failed:\(n)")
                }
            }
        }
    }
    
    func stop() {
        if let task = task, !task.isCancelled {
            task.cancel()
        }
        
    }
}
