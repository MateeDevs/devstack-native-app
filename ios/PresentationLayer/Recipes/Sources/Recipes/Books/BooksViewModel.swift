//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DevstackKmpShared
import Resolver
import SharedDomain
import SwiftUI
import UIToolkit

final class BooksViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected private(set) var getBooksUseCase: GetBooksUseCase
    @Injected private(set) var refreshBooksUseCase: RefreshBooksUseCase

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

    func onIntent(_ intent: Intent) {}
    
    // MARK: Private
    
    private func loadBooks() async {
        do {
            state.isLoading = true
            state.books = try await getBooksUseCase.execute()
            state.isLoading = false
            try await refreshBooksUseCase.execute(page: 0)
        } catch {}
    }
}
