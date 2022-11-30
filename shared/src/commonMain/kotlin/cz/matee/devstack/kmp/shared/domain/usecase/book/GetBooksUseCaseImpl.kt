package cz.matee.devstack.kmp.shared.domain.usecase.book

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import cz.matee.devstack.kmp.shared.domain.model.Book
import cz.matee.devstack.kmp.shared.domain.repository.BookRepository

interface GetBooksUseCase : UseCaseFlowNoParams<List<Book>>

internal class GetBooksUseCaseImpl constructor(
    private val repository: BookRepository
) : GetBooksUseCase {

    override suspend fun invoke() = repository.getAllBooks()

}