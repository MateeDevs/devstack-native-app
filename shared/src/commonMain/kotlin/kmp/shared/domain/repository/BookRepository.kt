package kmp.shared.domain.repository

import kmp.shared.base.Result
import kmp.shared.domain.model.Book
import kotlinx.coroutines.flow.Flow

internal interface BookRepository {
    fun getAllBooks(): Flow<List<Book>>

    suspend fun reloadAllBooks(): Result<Unit>
}
