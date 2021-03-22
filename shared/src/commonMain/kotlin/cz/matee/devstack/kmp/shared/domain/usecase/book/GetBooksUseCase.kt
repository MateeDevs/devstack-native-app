package cz.matee.devstack.kmp.shared.domain.usecase.book

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import cz.matee.devstack.kmp.shared.domain.model.Book
import cz.matee.devstack.kmp.shared.domain.repository.BookRepository
import kotlinx.coroutines.flow.Flow

class GetBooksUseCase internal constructor(private val repository: BookRepository) :
    UseCaseFlowNoParams<List<Book>>() {
    override suspend fun doWork(params: Unit): Flow<List<Book>> = repository.getAllBooks()
}