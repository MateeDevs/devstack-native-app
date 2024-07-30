package kmp.shared.core.domain.repository

import kmp.shared.core.base.Result
import kmp.shared.core.domain.model.Book
import kotlinx.coroutines.flow.Flow

internal interface BookRepository {
    fun getAllBooks(): Flow<List<Book>>

    suspend fun reloadAllBooks(): Result<Unit>
}
