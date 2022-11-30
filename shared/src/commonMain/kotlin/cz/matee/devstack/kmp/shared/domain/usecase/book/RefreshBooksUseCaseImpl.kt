package cz.matee.devstack.kmp.shared.domain.usecase.book

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.domain.repository.BookRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext

interface RefreshBooksUseCase : UseCaseResult<Int, Unit>

internal class RefreshBooksUseCaseImpl constructor(
    private val repository: BookRepository
) : RefreshBooksUseCase {

    override suspend fun invoke(params: Int) = withContext(Dispatchers.Default) {
        delay(2_000)
//        var factorial = 1
//        for (i in 1..params) {
//            factorial *= i
//        }
        repository.reloadAllBooks()
    }
}