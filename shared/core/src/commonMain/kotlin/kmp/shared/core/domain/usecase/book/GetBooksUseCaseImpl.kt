package kmp.shared.core.domain.usecase.book

import kmp.shared.core.base.usecase.UseCaseFlowNoParams
import kmp.shared.core.domain.model.Book
import kmp.shared.core.domain.repository.BookRepository

interface GetBooksUseCase : UseCaseFlowNoParams<List<Book>>

internal class GetBooksUseCaseImpl constructor(
    private val repository: BookRepository,
) : GetBooksUseCase {

    override suspend fun invoke() = repository.getAllBooks()
}
