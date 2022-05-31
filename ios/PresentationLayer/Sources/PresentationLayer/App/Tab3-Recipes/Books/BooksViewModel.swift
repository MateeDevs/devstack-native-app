//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DevstackKmpShared
import DomainLayer
import Resolver
import SwiftUI

final class BooksViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    // @Injected private(set) var getBooksUseCase: GetBooksUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await loadBooks() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var isLoading: Bool = false
        var books: [Book] = []
    }
    
    // MARK: Intent
    enum Intent {
    }

    @discardableResult
    func onIntent(_ intent: Intent) -> Task<Void, Never> {}
    
    // MARK: Private
    
    private func loadBooks() async {
        do {
            state.isLoading = true
            // state.books = try await getBooksUseCase.execute()
            // state.books = try await refreshBooksUseCase.execute()
            state.isLoading = false
        } catch {}
    }
}
