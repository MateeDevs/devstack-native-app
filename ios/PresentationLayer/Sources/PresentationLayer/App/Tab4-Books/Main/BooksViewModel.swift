//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared
import DomainLayer
import Resolver
import RxCocoa
import RxSwift

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
    
    init(
        getBooksUseCase: GetBooksUseCase,
        refreshBooksUseCase: RefreshBooksUseCase
    ) {
        
        // MARK: Setup inputs
        
        let page = PublishSubject<Int>()
        
        self.input = Input(
            page: page.asObserver()
        )
        
        // MARK: Transformations
        
        let books = getBooksUseCase.execute().ignoreErrors().share(replay: 1)
        
        let activity = ActivityIndicator()
        
        let refreshBooks = page.flatMap { _ -> Observable<Int> in
            refreshBooksUseCase.execute().map({ _ in 100 }).trackActivity(activity).ignoreErrors()
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
    }
}
