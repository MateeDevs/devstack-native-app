//
//  Created by David Kadlček on 14.04.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import DependencyInjection
import Factory
@testable import Recipes
import SharedDomain
import SharedDomainMocks
import KMPShared
import UIToolkit
import XCTest

@MainActor
final class BooksViewModelTests: XCTestCase {
    
    // MARK: Dependencies

    private let fc = FlowControllerMock<RecipesFlow>(navigationController: UINavigationController())
    
    private let getBooksUseCase = GetBooksUseCaseMock()
    private let refreshBooksUseCase = RefreshBooksUseCaseMock(
        executeReturnValue: ResultSuccess(data: KotlinUnit())
    )
    
    private func createViewModel() -> BooksViewModel {
        registerKMPMocks()
        
        return BooksViewModel(flowController: fc)
    }
    
    private func registerKMPMocks() {
        Container.shared.reset()
        Container.shared.getBooksUseCase.register { self.getBooksUseCase }
        Container.shared.refreshBooksUseCase.register { self.refreshBooksUseCase }
    }
    
    // MARK: Tests
    
    func testEmptyRefreshBooks() async {
        // given
        refreshBooksUseCase.executeReturnValue = ResultSuccess(data: KotlinUnit())
        
        // when
        let viewModel = createViewModel()
        await viewModel.awaitAllTasks()
        
        // then
        XCTAssertEqual(viewModel.state.books, [])
    }
    
    func testErrorRefreshBooks() async {
        // given
        refreshBooksUseCase.executeReturnValue = ResultError(
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
        getBooksUseCase.executeReturnValue = .stub
        
        // when
        let viewModel = createViewModel()
        await viewModel.awaitAllTasks()
        
        // then
        XCTAssertEqual(viewModel.state.books, .stub)
    }
}
