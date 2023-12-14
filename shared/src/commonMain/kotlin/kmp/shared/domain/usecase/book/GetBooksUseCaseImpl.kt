package kmp.shared.domain.usecase.book

import kmp.shared.base.usecase.UseCaseFlowNoParams
import kmp.shared.domain.model.Book
import kmp.shared.domain.repository.BookRepository

interface GetBooksUseCase : UseCaseFlowNoParams<List<Book>>

internal class GetBooksUseCaseImpl constructor(
    private val repository: BookRepository,
) : GetBooksUseCase {

    override suspend fun invoke() = repository.getAllBooks()
}
