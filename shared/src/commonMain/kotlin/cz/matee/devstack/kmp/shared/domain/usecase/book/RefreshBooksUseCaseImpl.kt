package cz.matee.devstack.kmp.shared.domain.usecase.book

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultImpl
import cz.matee.devstack.kmp.shared.domain.repository.BookRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext

open interface RefreshBooksUseCase : UseCaseResult<Int, Unit>

internal class RefreshBooksUseCaseImpl constructor(
    private val repository: BookRepository
) : UseCaseResultImpl<Int, Unit>(), RefreshBooksUseCase {

    override suspend fun doWork(params: Int): Result<Unit> = withContext(Dispatchers.Default) {
        delay(2_000)
        var factorial = 1
        for (i in 1..params) {
            factorial *= i
        }
        repository.reloadAllBooks()
    }
}