//
//  Created by David Kadlček on 14.04.2023
//  Copyright © 2023 Matee. All rights reserved.
//

@testable import Recipes
import Resolver
import SharedDomain
import SharedDomainMocks
import DevstackKmpShared
import UIToolkit
import XCTest

@MainActor
final class BooksViewModelTests: XCTestCase {
    
    // MARK: Dependencies

    private let fc = FlowControllerMock<RecipesFlow>(navigationController: UINavigationController())
    
    private let getBooksUseCaseMock = GetBooksUseCaseMock()
    private let refreshBooksUseCaseMock = RefreshBooksUseCaseMock(
        executeReturnValue:  ResultSuccess(data: KotlinUnit())
    )
    
    private func createViewModel() -> BooksViewModel {
        registerKMPMocks()
        
        return BooksViewModel(flowController: fc)
    }
    
    private func registerKMPMocks() {
        Resolver.register { self.getBooksUseCaseMock as GetBooksUseCase }
        Resolver.register { self.refreshBooksUseCaseMock as RefreshBooksUseCase }
    }
    
    // MARK: Tests
    
    func testEmptyRefreshBooks() async {
        // given
        refreshBooksUseCaseMock.executeReturnValue = ResultSuccess(data: KotlinUnit())
        
        // when
        let viewModel = createViewModel()
        await viewModel.awaitAllTasks()
        
        // then
        XCTAssertEqual(viewModel.state.books, [])
    }
    
    func testErrorRefreshBooks() async {
        // given
        refreshBooksUseCaseMock.executeReturnValue = ResultError(
            error: TestError(message: nil, throwable: nil), data: nil
        )
        
        // when
        let viewModel = createViewModel()
        await viewModel.awaitAllTasks()
        
        // then
        XCTAssertEqual(viewModel.state.books, [])
    }
    
    func testFetchBooks() async {
        // given
        let books = [Book(id: "1", name: "Kniha", author: "David", pages: 25)]
        getBooksUseCaseMock.executeReturnValue = books
        
        // when
        let viewModel = createViewModel()
        await viewModel.awaitAllTasks()
        
        // then
        XCTAssertEqual(viewModel.state.books, books)
    }
}
