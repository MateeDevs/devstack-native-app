package cz.matee.devstack.kmp.shared.domain.usecase.book

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParamsImpl
import cz.matee.devstack.kmp.shared.domain.model.Book
import cz.matee.devstack.kmp.shared.domain.repository.BookRepository
import kotlinx.coroutines.flow.Flow

open interface GetBooksUseCase : UseCaseFlowNoParams<List<Book>>

internal class GetBooksUseCaseImpl constructor(private val repository: BookRepository) :
    UseCaseFlowNoParamsImpl<List<Book>>(), GetBooksUseCase {
    override suspend fun doWork(params: Unit): Flow<List<Book>> = repository.getAllBooks()
}