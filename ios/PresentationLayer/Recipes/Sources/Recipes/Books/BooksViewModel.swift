//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DevstackKmpShared
import Resolver
import SharedDomain
import SwiftUI
import UIToolkit

struct BooksState: VmState {
    let isLoading: Bool
    let books: [Book]
    
    init() {
        isLoading = true
        books = []
    }
}

// Copy
extension BooksState {
    init(
        copy: BooksState,
        isLoading: Bool? = nil,
        books: [Book]? = nil
    ) {
        self.isLoading = isLoading ?? copy.isLoading
        self.books = books ?? copy.books
    }
}

enum BooksIntent: VmIntent {
    case refreshBooks
    case onLoadData(books: [Book])
}

final class BooksMVIViewModel: IntentViewModel<BooksState, BooksIntent> {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?

    @Injected private(set) var getBooksUseCase: GetBooksUseCase
    @Injected private(set) var refreshBooksUseCase: RefreshBooksUseCase
    
    init(flowController: FlowController?) {
        self.flowController = flowController
        
        super.init()
        
        observeBooks()
    }
    
    override func onAppear() {
        super.onAppear()
        onIntent(intent: .refreshBooks)
    }
    
    override func applyIntent(intent: BooksIntent) -> BooksState {
        switch intent {
        case .refreshBooks:
            refreshBooks()
            return BooksState(copy: state, isLoading: true, books: [])
        case .onLoadData(let books):
            // There is used isLoading ternary operator just for demo purpose
            return BooksState(copy: state, isLoading: books.isEmpty ? true : false, books: books)
        }
    }
    
    private func refreshBooks() {
        Task {
            do {
                try await refreshBooksUseCase.execute(params: 0)
            } catch {
            }
        }
    }
    
    private func observeBooks() {
        Task {
            for try await books: [Book] in getBooksUseCase.execute() {
                onIntent(intent: .onLoadData(books: books))
            }
        }
    }
}
