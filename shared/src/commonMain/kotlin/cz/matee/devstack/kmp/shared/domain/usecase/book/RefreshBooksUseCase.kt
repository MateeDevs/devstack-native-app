package cz.matee.devstack.kmp.shared.domain.usecase.book

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.domain.repository.BookRepository

class RefreshBooksUseCase internal constructor(
    private val repository: BookRepository
) : UseCaseResultNoParams<Unit>() {

    override suspend fun doWork(params: Unit): Result<Unit> {
        return repository.reloadAllBooks()
    }
}