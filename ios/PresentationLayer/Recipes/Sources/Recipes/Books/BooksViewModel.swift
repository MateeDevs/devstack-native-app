//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DependencyInjection
import KMPShared
import Factory
import SharedDomain
import SwiftUI
import UIToolkit

final class BooksViewModel: BaseViewModel, ViewModel, ObservableObject {

    // MARK: Dependencies
    private weak var flowController: FlowController?

    @Injected(\.getBooksUseCase) private(set) var getBooksUseCase
    @Injected(\.refreshBooksUseCase) private(set) var refreshBooksUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()

        // start book observing
        executeTask(Task {
            await observeBooks()
        })
    }

    // MARK: Lifecycle

    override func onAppear() {
        super.onAppear()
        onIntent(.refreshBooks)
    }

    // MARK: State

    @Published private(set) var state: State = State()

    struct State {
        var isLoading: Bool = true
        var books: [Book] = []
    }

    // MARK: Intent

    enum Intent {
        case refreshBooks
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .refreshBooks: await refreshBooks()
            }
        })
    }

    // MARK: Private

    private func observeBooks() async {
        for try await books: [Book] in getBooksUseCase.execute() {
            if !books.isEmpty {
                // Just for demo purpose:
                // We have only simple stream and first value is empty db..
                // therefore I'll wait until we receive non empty list
                state.isLoading = false
            }
            state.books = books
        }
    }

    private func refreshBooks() async {
        do {
            try await refreshBooksUseCase.execute(params: 0)
        } catch {
        }
    }
}
