
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.


 import class DevstackKmpShared.Book
 import DomainLayer
 import RxCocoa
 import RxSwift

 final class BooksViewModel: BaseViewModel, ViewModel {

    typealias Dependencies =
        HasGetBooksUseCase &
        HasRefreshBooksUseCase

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

    init(dependencies: Dependencies) {

        // MARK: Setup inputs

        let page = PublishSubject<Int>()

        self.input = Input(
            page: page.asObserver()
        )

        // MARK: Transformations

        let books = dependencies.getBooksUseCase.execute().ignoreErrors().share(replay: 1)

        let activity = ActivityIndicator()

        let refreshUsers = page.flatMap { _ -> Observable<Int> in
            dependencies.refreshBooksUseCase.execute().map({ _ in 100 }).trackActivity(activity).ignoreErrors()
        }.share()

        let isRefreshing = Observable<Bool>.merge(
            activity.asObservable(),
            refreshUsers.map { _ in false }
        )

        // MARK: Setup outputs

        self.output = Output(
            books: books.asDriver(),
            loadedCount: refreshUsers.asDriver(),
            isRefreshing: isRefreshing.asDriver()
        )

        super.init()
    }
 }
