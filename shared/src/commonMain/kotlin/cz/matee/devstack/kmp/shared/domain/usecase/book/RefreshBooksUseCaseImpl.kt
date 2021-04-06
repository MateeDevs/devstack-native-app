package cz.matee.devstack.kmp.shared.domain.usecase.book

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParamsImpl
import cz.matee.devstack.kmp.shared.domain.repository.BookRepository

interface RefreshBooksUseCase : UseCaseResultNoParams<Unit>

class RefreshBooksUseCaseImpl internal constructor(
    private val repository: BookRepository
) : UseCaseResultNoParamsImpl<Unit>(), RefreshBooksUseCase {

    override suspend fun doWork(params: Unit): Result<Unit> {
        return repository.reloadAllBooks()
    }
}